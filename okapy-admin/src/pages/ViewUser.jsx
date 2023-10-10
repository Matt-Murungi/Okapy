import {
  Box,
  Button,
  HStack,
  Image,
  Text,
  useToast,
  VStack,
} from "@chakra-ui/react";
import React, { useEffect, useState, useCallback } from "react";
import { FiEye } from "react-icons/fi";
import { GrEdit } from "react-icons/gr";
import { IoSearchOutline } from "react-icons/io5";
import { useLocation, useNavigate } from "react-router-dom";
import { Transaction } from "../assets/svg";
import BreadCrumb from "../components/general/BreadCrumb";
import CustomModal from "../components/general/CustomModal";
import DeactivateButton from "../components/general/DeactivateButton";
// import { GoGraph } from "react-icons/go";
import CInput from "../components/general/Input";
import _ from "lodash";
import Wrapper from "../components/general/Wrapper";
import BookingServices from "../utils/services/BookingServices";
import UserServices from "../utils/services/UserServices";
import EditUserModal from "../components/settings_user/EditUserModal";
import { ConfigProvider, Popconfirm, Table } from "antd";
import { toastProps } from "../utils/Helper";

const ViewUser = () => {
  const navigate = useNavigate();
  const [user, setUser] = useState([]);
  const [userBookings, setUserBookings] = useState([]);
  const [filterUserBookings, setFilterUserBookings] = useState([]);
  const [searchValue, setSearchValue] = useState("");
  const [loading, setLoading] = useState(true)
  const [openModal, setOpenModal] = useState(false);
  const [current, setCurrent] = useState({});

  const toast = useToast();

  const location = useLocation()?.pathname.split("/");

  let id = location[location?.length - 1];

  useEffect(() => {
    setLoading(true);
    UserServices.fetchUsers().then((response) => {
      setUser(response.find((user) => user.id === parseInt(id)));
    });

    BookingServices.ownersBookings(id).then((response) => {
      let arr = [];
      response.forEach(async (element) => {
        const receiver = await BookingServices.getBookingReceiver(element?.booking?.id);
        const bookingObj = {
          pickup: element?.booking?.formated_address || "",
          destination: receiver?.formated_address || "",
          sender: element?.owner?.first_name + " " + element?.owner?.last_name || "",
          senderPhoneNumber: element?.owner?.phonenumber || "",
          receiver: receiver?.name || "",
          receiverPhoneNumber: receiver?.phonenumber || "",
          driver: element?.driver?.first_name + " " + element?.driver?.last_name || "",
          driverPhoneNumber: element?.driver?.phonenumber || "",
          status: element?.status,
          id: element?.id,
        };
        arr.push(bookingObj);
      })
      setUserBookings(arr);
      setFilterUserBookings(arr);
      setTimeout(() => setLoading(false), 1000);
    });

  }, [id]);

  const handleSearch = (arr, cond) => {
    const newArr = _.filter(arr, (obj) => {
      if (cond) {
        return (
          obj?.pickup?.toLowerCase()?.includes(cond?.toLowerCase()) ||
          obj?.destination?.toLowerCase()?.includes(cond?.toLowerCase()) ||
          obj?.sender?.toLowerCase()?.includes(cond?.toLowerCase()) ||
          obj?.receiver?.toLowerCase()?.includes(cond?.toLowerCase()) ||
          obj?.driver?.toLowerCase()?.includes(cond?.toLowerCase())
        );
      }
    });

    if (cond) return newArr;
    else return userBookings;
  };

  useEffect(() => {
    setFilterUserBookings(handleSearch(userBookings, searchValue));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [userBookings, searchValue]);

  const columns = [
    {
      title: "Destination",
      dataIndex: "destination",
      sorter: (a, b) => a?.destination.localeCompare(b?.destination),
    },
    {
      title: "Receiver",
      dataIndex: "receiver",
      sorter: (a, b) => a?.receiver.localeCompare(b?.receiver),
    },
    {
      title: "Driver",
      dataIndex: "driver",
      sorter: (a, b) => a?.driver.localeCompare(b?.driver),
    },
    {
      title: "Status",
      dataIndex: "status",
      render: (text) => {
        const bg =
          text === 0
            ? "bg-primary_red"
            : text === 5
              ? "bg-primary_green"
              : "bg-primary_yellow_light";

        return (
          <Box display={"flex"}>
            <Box
              py={"1"}
              px={"2"}
              fontSize={"xs"}
              textTransform={"capitalize"}
              className={`${bg} rounded-md font-medium text-center text-white`}
            >
              {STATUS_LIST[text]}
            </Box>
          </Box>
        );
      }
    },
    {
      title: "Action",
      dataIndex: "action",
      render: (_, n) => {
        return (
          <Box className="flex gap-6 justify-start">
            <ActionButton >
              <FiEye onClick={() => handleViewUser(n?.id)}
              />
            </ActionButton>
          </Box>
        );
      },
    },
  ]

  const handleOpenModal = useCallback(() => {
    setOpenModal(true);
  }, []);

  const handleCloseModal = useCallback(() => {
    setOpenModal(false);
  }, []);

  const handleViewUser = (user) => {
    navigate(`/users/${user}`, user);
  };

  const handleDeactivateUser = async () => {
    try {
      setLoading(true);
      const data = {
        id: user?.id,
        is_active: !user?.is_active,
        email: user?.email,
        phonenumber: user?.phonenumber,
      };

      await UserServices.updateUser(data);

      toast({
        ...toastProps,
        title: "Success!",
        description: user.is_active ? "user deactivated!" : "user Activated!",
        status: "success",
      });
      navigate(-1);
      setLoading(false);
    } catch (error) {
      toast({
        ...toastProps,
        title: "Error!",
        description: user.is_active
          ? "user not deactivated!"
          : "user not Activated!",
        status: "error",
      });
      setLoading(false);
    }
  };
  // const

  return (
    <>
      <Box p={"3"} maxH={"91%"} overflowY={"scroll"}>
        <BreadCrumb
          icon={<Transaction />}
          title={`User management /`}
          subtitle={user?.first_name + " " + user?.last_name}
        />
        <Box className="flex gap-3 ">
          <Box className="w-2/5">
            <Wrapper
              my={"4"}
              p={"10"}
              borderRadius={"none"}
              className={"flex flex-col justify-center items-center rounded"}
            >
              {/* body */}
              <Box
                className="rounded-full overflow-hidden"
                h={40}
                w={40}
                bg={"gray.300"}
                mb={"3"}
              >
                <Image h={"full"} objectFit={"cover"} src={user?.image} />
              </Box>
              <Text
                fontSize={"xl"}
                textTransform={"uppercase"}
                fontWeight={"semibold"}
              >
                {user?.first_name}
              </Text>

              <Text fontSize={"sm"} fontWeight={"light"}>
                Customer
              </Text>

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
                <Popconfirm
                  placement="top"
                  title={
                    `Are you sure you want to ${user.is_active ? "deactivate " : "activate "
                    } ` + user?.first_name
                  }
                  onConfirm={handleDeactivateUser}
                  okText="Yes"
                  cancelText="No"
                  okButtonProps={{ type: "default" }}
                  cancelButtonProps={{ type: "link", color: "red" }}
                >
                  <Box>
                    <DeactivateButton
                      className={`mt-1 cursor-pointer ${user?.is_active === false
                        ? "bg-primary_green text-white"
                        : "bg-red-100  text-red-600 "
                        }`}
                    // handleClick={() => setShowConfirm(true)}
                    >
                      <Text
                        fontSize={"sm"}
                        textTransform={"capitalize"}
                        fontWeight={"medium"}
                      >
                        {user?.is_active ? "Deactivate user" : "Activate user"}
                      </Text>
                    </DeactivateButton>
                  </Box>
                </Popconfirm>
              </ConfigProvider>
            </Wrapper>

            {/* Personal information*/}
            <Box>
              <Box className="flex justify-between py-2 px-5">
                <Text fontSize={"lg"} fontWeight={"medium"}>
                  Personal information
                </Text>

                <CustomModal
                  // loading={loading}
                  // handleSave={handleCreate}
                  title={"Add User"}
                // isOpen={openModal}
                // onClose={() => setOpenModal(false)}
                // button={
                //   // <PrimaryButton
                //   //   className={"text-sm items-end"}
                //   //   handleClick={() => setOpenModal(true)}
                //   // >
                //   //   <GrAdd className="text-lg" />
                //   //   <Text fontWeight={"medium"}>Add User</Text>
                //   // </PrimaryButton>
                // }
                >
                  <VStack gap={"2"} w={"full"}>
                    {/* <Box className="flex w-full flex-col gap-1">
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
                </Box> */}

                    <Box className="flex w-full flex-col gap-1">
                      <Text fontSize={"sm"}>Category</Text>

                      {/* <CInput
                    h={"10"}
                    w={3 / 4}
                    placeholder=""
                    borderRadius={"md"}
                  /> */}

                      {/* <CSelect
                    handleChange={(selected) =>
                      setUser((prev) => ({
                        ...prev,
                        category: selected,
                      }))
                    }
                    h={"10"}
                    w={3 / 4}
                  /> */}
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

                    {/* <Box className="flex w-full flex-col gap-1">
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
                </Box> */}
                  </VStack>
                </CustomModal>
                <ActionButton>
                  <GrEdit
                    onClick={() => {
                      setCurrent({
                        id: user?.id,
                        first_name: user?.first_name,
                        last_name: user?.last_name,
                        is_admin: user?.is_admin,
                        is_driver: user?.is_driver,
                        email: user?.email,
                        phonenumber: user?.phonenumber,
                      });
                      handleOpenModal();
                    }}
                  />
                </ActionButton>
              </Box>
              <Wrapper
                my={"2"}
                p={"10"}
                borderRadius={"none"}
                className={"flex justify-center items-center gap-3 text-[14px]"}
              >
                <Box className="text-right flex flex-col gap-3">
                  <Text fontWeight={"medium"}>Full name</Text>
                  <Text fontWeight={"medium"}>Category</Text>
                  {/* <Text fontWeight={"medium"}>Location</Text> */}
                  <Text fontWeight={"medium"}>Email</Text>
                  <Text fontWeight={"medium"}>Phone number</Text>
                  <Text fontWeight={"medium"}>Onboarding date</Text>
                  <Text fontWeight={"medium"}>Last edit date</Text>
                </Box>

                <div className={"bg-zinc-200 h-60 w-0.5 rounded-full"} />

                <Box className="text-left flex flex-col gap-4">
                  <Text>
                    {user?.first_name} {user?.last_name}
                  </Text>
                  <Text>
                    {user?.is_admin
                      ? "Admin"
                      : user?.is_driver
                        ? "Driver"
                        : "User"}
                  </Text>
                  {/* <Text>Nairobi CBD, Nairobi</Text> */}
                  <Text>{user?.email}</Text>
                  <Text>{user?.phonenumber}</Text>
                  <Text>{user?.date_joined}</Text>
                  <Text>3/10/2022</Text>
                </Box>
              </Wrapper>
            </Box>

            {/* vehicle information */}
            {/* <Box>
            <Box className="flex justify-between py-2 px-5">
              <Text fontSize={"lg"} fontWeight={"medium"}>
                Payment Details
              </Text>

              <ActionButton>
                <GrEdit />
              </ActionButton>
            </Box>
            <Wrapper my={"2"} borderRadius={"none"} className={"gap-3"}>
              {/* mini cards */}
            {/* <HStack w={"full"} fontFamily={"Poppins"}>
                <MiniCard no={"24"} text={"Total Bookings"} icon={<Lorry />} />
                <MiniCard
                  no={"3"}
                  text={"Canceled Bookings"}
                  icon={<Lorry />}
                />
                <MiniCard
                  no={"KES. 140,000"}
                  text={"Customer Value"}
                  icon={<GoGraph />}
                />
              </HStack>

              <Box mt={"3"}>
                <Table headers={[...Object.keys(sample_payment_data[0])]}>
                  {sample_payment_data?.map((data, key) => {
                    const isEven = key % 2;

                    return (
                      <tr
                        className={`h-14 capitalize ${
                          isEven ? "bg-[#F9F9F9]" : "white"
                        }`}
                      >
                        <td className=" py-3 px-4">{data?.date}</td>
                        <td className=" py-3 px-4">
                          {data?.["method of payment"]}
                        </td>
                        <td className="py-3 px-4">{data?.amount}</td>
                      </tr>
                    );
                  })}
                </Table>
              </Box>
            </Wrapper>
          </Box>  */}
          </Box>

          {/* table */}
          <Wrapper mb={"2"} mt={3} p={"5 "} className={"w-3/5"}>
            <Text fontWeight={"semibold"} fontSize={"lg"}>
              Bookings
            </Text>

            {/* search and table actions */}
            <HStack py={"6"} justifyContent={"space-between"}>
              {/* /search input */}
              <CInput
                icon={<IoSearchOutline className="text-xl" />}
                handleChange={(e) => {
                  setSearchValue(e?.target?.value);
                }}
              />
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
                  loading={loading}
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
                  dataSource={filterUserBookings}
                />
              </Box>
            </ConfigProvider>
          </Wrapper>
        </Box>
      </Box>

      <EditUserModal
        openModal={openModal}
        handleCloseModal={handleCloseModal}
        current={current}
      />
    </>
  );
};

export default ViewUser;

// const tableData = [
//   {
//     destination: "Brooke Manor",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 4,
//   },
//   {
//     destination: "Brooke Manor",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 5,
//   },
//   {
//     destination: "Brooke Manor",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 0,
//   },
//   {
//     destination: "Brooke Manor",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 1,
//   },
//   {
//     destination: "Brooke Manor",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 2,
//   },
//   {
//     destination: "Brooke Manor",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 3,
//   },
//   {
//     destination: "Brooke Manor",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 4,
//   },
//   {
//     destination: "Brooke Manor",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 5,
//   },
// ];
const STATUS_LIST = {
  1: "arrived at pickup",
  2: "picked up",
  3: "on trip",
  4: "arrived destination",
  0: "cancelled",
  5: "completed",
};
const ActionButton = ({ bg, children, handleClick }) => (
  <Button
    fontSize={"lg"}
    p={"0"}
    h={"30px"}
    className={`${bg} rounded-md  text-dark_green border border-dark_green`}
    onClick={handleClick}
  >
    {children}
  </Button>
);

// const MiniCard = ({ text, no, icon }) => (
//   <Box borderRadius={"xl"} h={"20"} p={"2"} flexGrow={"1"}>
//     <Text fontSize={"sm"} className={"text-zinc-400"}>
//       {text}
//     </Text>
//     <Box className="flex justify-between items-center">
//       <Text fontWeight={"bold"} fontSize={"lg"}>
//         {no}
//       </Text>

//       <Center
//         h={"40px"}
//         w={"40px"}
//         p={"1.5"}
//         bg={"current_bg"}
//         borderRadius={"md"}
//       >
//         {icon}
//       </Center>
//     </Box>
//   </Box>
// );

// const sample_payment_data = [
//   {
//     date: "5/3/2019",
//     "method of payment": "Mpesa",
//     amount: "350",
//   },
//   {
//     date: "5/3/2019",
//     "method of payment": "Mpesa",
//     amount: "350",
//   },
//   {
//     date: "5/3/2019",
//     "method of payment": "Mpesa",
//     amount: "350",
//   },
// ];
