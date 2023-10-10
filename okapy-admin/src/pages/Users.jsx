import {
  Box,
  Button,
  Center,
  HStack,
  Text,
  useToast,
  VStack,
} from "@chakra-ui/react";
import _ from "lodash";
import React, { useEffect, useState } from "react";
import { AiFillLock, AiOutlineMail } from "react-icons/ai";
import { BsPeople, BsPerson, BsTelephone } from "react-icons/bs";
import { GrAdd } from "react-icons/gr";
import { IoSearchOutline } from "react-icons/io5";
import { Link, useNavigate } from "react-router-dom";
import BreadCrumb from "../components/general/BreadCrumb";
import CustomModal from "../components/general/CustomModal";
import CInput, { CSelect } from "../components/general/Input";
import PrimaryButton from "../components/general/PrimaryButton";
import { ConfigProvider, Popconfirm, Table } from "antd";
import { FiEye } from "react-icons/fi";
import { RiDeleteBin5Line } from "react-icons/ri";
import Wrapper from "../components/general/Wrapper";
import { toastProps } from "../utils/Helper";
import UserServices from "../utils/services/UserServices";

const Users = () => {
  const navigate = useNavigate();
  const [users, setUsers] = useState([]);
  const [filteredUser, setFilteredUsers] = useState([]);
  const [search, setSearch] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [stateLoading, setStateLoading] = useState(true);

  const [openModal, setOpenModal] = useState(false);
  const [user, setUser] = useState({
    name: "",
    category: "",
    email: "",
    phone: "",
    password: "",
  });
  const toast = useToast();

  useEffect(() => {
    setStateLoading(true);

    UserServices.fetchUsers().then((response) => {
      let arr = [];
      for (let i = 0; i <= response?.length; i++) {
        const newUser = response[i];
        const category = newUser?.is_admin
          ? "admin"
          : newUser?.is_driver
          ? "driver"
          : "user";
        const status = STATUS_LIST[newUser?.is_active];
        const newUserObj = {
          fullname: newUser?.first_name || "" + newUser?.last_name || "",
          phone: newUser?.phonenumber || "",
          email: newUser?.email || "",
          category,
          status,
          id: newUser?.id,
        };

        arr.push(newUserObj);
      }

      setUsers(arr);

      setFilteredUsers(arr);
      setStateLoading(false);
    });
  }, []);

  const handleDeleteUser = async (id) => {
    setLoading(true);
    try {
      await UserServices.deleteUser(id);

      toast({
        ...toastProps,
        title: "Success!",
        description: "Vehicle deleted!",
        status: "success",
      });
      setLoading(false);
    } catch (error) {
      toast({
        ...toastProps,
        title: "Error!",
        description: "Vehicle not deleted. An error occured! " + error?.message,
        status: "error",
      });
      console.log("DELETE VEHICLE ERROR:", error);
      setLoading(false);
    }
  };

  const columns = [
    {
      title: "Fullname",
      dataIndex: "fullname",
      render: (text, u) => (
        <Link as={"a"} to={"/users/" + u?.id}>
          {text}
        </Link>
      ),
      sorter: (a, b) => a?.fullname.localeCompare(b?.fullname),
    },
    {
      title: "Email",
      dataIndex: "email",
      sorter: (a, b) => a?.email.localeCompare(b?.email),
    },
    {
      title: "Phone",
      dataIndex: "phone",
    },
    {
      title: "Category",
      dataIndex: "category",
      filters: [...userCategories],
      render: (text) => <Box className={"text-uppercase"}>{text}</Box>,
      onFilter: (value, record) =>
        record.category.startsWith(value?.toLowerCase()),
    },
    {
      title: "Status",
      dataIndex: "status",
      render: (text) => {
        const bg =
          text?.toLowerCase() === "deactivated"
            ? "bg-primary_red"
            : "bg-primary_green";
        return (
          <Box display={"flex"}>
            <Box
              py={"1"}
              px={"2"}
              fontSize={"xs"}
              textTransform={"capitalize"}
              className={`${bg} rounded-md font-medium text-center text-white`}
            >
              {text}
            </Box>
          </Box>
        );
      },
    },
    {
      title: "Action",
      dataIndex: "action",
      render: (_, n) => {
        return (
          <Box className="flex gap-6 justify-start">
            <ActionButton handlePress={() => handleViewUser(n)}>
              <FiEye />
            </ActionButton>

            <Popconfirm
              placement="top"
              title={`Are you sure you want to Delete ` + n?.fullname}
              onConfirm={() => handleDeleteUser(n?.id)}
              okText="Yes"
              cancelText="No"
              okButtonProps={{ type: "default" }}
              cancelButtonProps={{ type: "link", color: "red" }}
            >
              <Box>
                <ActionButton>
                  <RiDeleteBin5Line />
                </ActionButton>
              </Box>
            </Popconfirm>
          </Box>
        );
      },
    },
  ];

  const handleChange = (e) => {
    const { name, value } = e?.target;
    setUser((prev) => ({ ...prev, [name]: value }));
  };

  const groupings = React.useMemo(() => {
    const admins = _.filter(users, { category: "admin" });
    const drivers = _.filter(users, { category: "driver" });
    const senders = _.filter(users, {
      category: "user",
    });

    return {
      admins: admins.length,
      drivers: drivers.length,
      senders: senders.length,
      receivers: 0,
    };
  }, [users]);

  const handleSearch = (arr, cond) => {
    const newArr = _.filter(arr, (obj) => {
      const name = `${obj?.fullname}`;
      if (cond) {
        return (
          name?.includes(cond?.toLowerCase()) ||
          obj?.email?.includes(cond?.toLowerCase()) ||
          obj?.phone?.includes(cond?.toLowerCase())
        );
      }
    });

    if (cond) return newArr;
    else return users;
  };

  const handleCreate = async () => {
    setLoading(true);
    try {
      if (user?.category === "user") {
        await UserServices.createUser({
          ...user,
          password1: user?.password,
          password2: user?.password,
        });
      } else {
        await UserServices.createDriver({
          ...user,
          password1: user?.password,
          password2: user?.password,
        });
      }

      setLoading(false);

      toast({
        ...toastProps,
        title: "Success!",
        description: "User created successfully",
        status: "success",
      });
      UserServices.fetchUsers().then((response) => {
        setUsers(response);
        setFilteredUsers(response);
      });
    } catch (error) {
      toast({
        ...toastProps,
        title: "Error!",
        description: error?.message,
        status: "error",
      });
      console.log("USER CREATE ERROR:", error);
    }
  };

  React.useEffect(() => {
    setFilteredUsers(handleSearch(users, search));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [search, users]);

  // React.useEffect(() => {
  //   if (selectedFilter === "") {
  //     setFilteredUsers(users);
  //     return;
  //   }
  //   setFilteredUsers(handleFilter(selectedFilter));
  // }, [handleFilter, selectedFilter, users]);

  const handleViewUser = (user) => {
    console.log(user);
    if (user?.category === "driver") {
      navigate(`driver/${user?.id}`, user);
      return;
    }
    navigate(`${user?.id}`, user);
  };
  return (
    <Box p={"3"} maxH={"91%"} overflowY={"scroll"}>
      <BreadCrumb icon={<BsPeople />} title={"User management"} />

      <HStack py={"2"} pt={"3"} gap={3}>
        {cards_data?.map((item) => (
          <UserCard
            no={groupings[item?.text?.toLowerCase()]}
            text={item?.text}
          />
        ))}
      </HStack>

      <Wrapper my={"2"} p={"3"}>
        {/* search and table actions */}
        <HStack py={"3"} justifyContent={"space-between"} alignItems={"end"}>
          {/* /search input */}
          <Box>
            <CInput
              icon={<IoSearchOutline className="text-xl" />}
              handleChange={(e) => {
                setSearch(e?.target?.value);
              }}
            />
          </Box>
          {/* actions */}
          <HStack gap={"2"}>
            <CustomModal
              loading={loading}
              handleSave={handleCreate}
              title={"Add User"}
              isOpen={openModal}
              onClose={() => setOpenModal(false)}
              button={
                <PrimaryButton
                  className={"text-sm items-end"}
                  handleClick={() => setOpenModal(true)}
                >
                  <GrAdd className="text-lg" />
                  <Text fontWeight={"medium"}>Add User</Text>
                </PrimaryButton>
              }
            >
              <VStack gap={"2"} w={"full"}>
                <Box className="flex w-full flex-col gap-1">
                  <Text fontSize={"sm"}>Full name</Text>

                  <CInput
                    handleChange={handleChange}
                    h={"10"}
                    w={3 / 4}
                    placeholder=""
                    name={"name"}
                    value={user?.name}
                    icon={<BsPerson className="text-xl" />}
                    borderRadius={"md"}
                  />
                </Box>

                <Box className="flex w-full flex-col gap-1">
                  <Text fontSize={"sm"}>Category</Text>

                  {/* <CInput
                    h={"10"}
                    w={3 / 4}
                    placeholder=""
                    borderRadius={"md"}
                  /> */}

                  <CSelect
                    handleChange={(selected) =>
                      setUser((prev) => ({
                        ...prev,
                        category: selected,
                      }))
                    }
                    h={"10"}
                    w={3 / 4}
                  >
                    <option value="user">User</option>
                    <option value="driver">Driver</option>
                  </CSelect>
                </Box>

                {/* <Box className="flex w-full flex-col gap-1">
                  <Text fontSize={"sm"}>Location</Text>
                  <CInput
                    h={"10"}
                    w={3 / 4}
                    placeholder=""
                    icon={<GrLocation className="text-xl" />}
                    borderRadius={"md"}
                  />
                </Box> */}

                <Box className="flex w-full flex-col gap-1">
                  <Text fontSize={"sm"}>Email</Text>

                  <CInput
                    handleChange={handleChange}
                    value={user?.email}
                    name={"email"}
                    h={"10"}
                    w={3 / 4}
                    placeholder=""
                    icon={<AiOutlineMail className="text-xl" />}
                    borderRadius={"md"}
                  />
                </Box>

                <Box className="flex w-full flex-col gap-1">
                  <Text fontSize={"sm"}>Phone</Text>

                  <CInput
                    handleChange={handleChange}
                    value={user?.phone}
                    name={"phone"}
                    h={"10"}
                    w={3 / 4}
                    placeholder=""
                    icon={<BsTelephone className="text-xl" />}
                    borderRadius={"md"}
                  />
                </Box>

                <Box className="flex w-full flex-col gap-1">
                  <Text fontSize={"sm"}>Password</Text>

                  <CInput
                    handleChange={handleChange}
                    value={user?.password}
                    handleEyeClick={() => setShowPassword(!showPassword)}
                    name={"password"}
                    h={"10"}
                    w={3 / 4}
                    placeholder="password"
                    type={showPassword ? "name" : "password"}
                    icon={<AiFillLock className="text-xl" />}
                    borderRadius={"md"}
                  />
                </Box>
              </VStack>
            </CustomModal>
          </HStack>
        </HStack>

        {/* body */}
        <ConfigProvider
          theme={{
            token: {
              colorPrimary: "#EFAF1C",
              colorPrimaryTextActive: "#19411D",
              colorPrimaryText: "#19411D",
              // colorBgBase: "#19411D",
              colorPrimaryBg: "#EFAF1C",
            },
          }}
        >
          <Box>
            <Table
              rowKey={(data) => data.id}
              loading={stateLoading}
              pagination={{
                defaultPageSize: 15,
                showSizeChanger: true,
                pageSizeOptions: ["10", "15", "20", "30"],
              }}
              // rowSelection={{
              //   type: "checkbox",
              //   ...rowSelection,
              // }}
              columns={columns}
              dataSource={filteredUser}
            />
          </Box>
        </ConfigProvider>
      </Wrapper>
    </Box>
  );
};

// rowSelection object indicates the need for row selection
export default Users;

const STATUS_LIST = {
  true: "active",
  false: "deactivated",
};

const userCategories = [
  { text: "Admin", value: "Admin" },
  { text: "User", value: "User" },
  { text: "Driver", value: "Driver" },
];
const ActionButton = ({ bg, children, handlePress }) => (
  <Button
    fontSize={"lg"}
    p={"0"}
    h={"30px"}
    className={`${bg} rounded-md  text-dark_green border border-dark_green`}
    onClick={handlePress}
  >
    {children}
  </Button>
);

const cards_data = [
  {
    text: "Senders",
    number: 152,
  },
  {
    text: "Drivers",
    number: 60,
  },
  {
    text: "Admins",
    number: 5,
  },
  {
    text: "Receivers",
    number: 70,
  },
];

const UserCard = ({ text, no }) => (
  <HStack bg={"white"} borderRadius={"xl"} h={"28"} w={1 / 4} px={"5"}>
    <Box className="flex-grow">
      <Text fontSize={"sm"} className={"text-zinc-400"}>
        {text}
      </Text>
      <Text fontWeight={"bold"} fontSize={"2xl"}>
        {no}
      </Text>
    </Box>

    <Center p={"2"} bg={"current_bg"} borderRadius={"md"}>
      <BsPeople className="text-2xl" />
    </Center>
  </HStack>
);
