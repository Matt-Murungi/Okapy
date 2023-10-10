import { Box, Button, Center, HStack, Text, useToast } from "@chakra-ui/react";
import React, { useEffect, useState } from "react";
import BreadCrumb from "../components/general/BreadCrumb";
import { ConfigProvider, Popconfirm, Table } from "antd";
import Wrapper from "../components/general/Wrapper";

import _ from "lodash";
import { FiEye } from "react-icons/fi";
import { IoSearchOutline } from "react-icons/io5";
import { RiCarLine, RiDeleteBin5Line } from "react-icons/ri";
import { useNavigate, Link } from "react-router-dom";
import { Lorry } from "../assets/svg";
import CInput from "../components/general/Input";
import FleetServices from "../utils/services/FleetServices";
import { toastProps } from "../utils/Helper";

const Fleet = () => {
  const navigate = useNavigate();
  const toast = useToast();

  const [vehicles, setVehicles] = useState([]);
  const [filteredVehicles, setFilteredVehicles] = useState([]);
  const [search, setSearch] = useState("");
  const [stateLoading, setStateLoading] = useState(true);
  const [loading, setLoading] = useState(false);

  const handleViewFleet = (fleet) => {
    navigate(`${fleet?.id}`, fleet?.id);
  };

  useEffect(() => {
    FleetServices.fetchVehicles().then((response) => {
      let arr = [];
      response.forEach((element) => {
        const fleetObj = {
          regNumber: element?.reg_number || "",
          fullname:
            element?.owner?.first_name + " " + element?.owner?.last_name || "",
          insuranceExpiry: element?.insurance_expiry || "",
          id: element?.id,
        };
        arr.push(fleetObj);
      });
      setVehicles(arr);
      setFilteredVehicles(arr);
      setStateLoading(false);
    });
  }, []);

  const handleSearch = (arr, cond) => {
    const newArr = _.filter(arr, (obj) => {
      if (cond) {
        return (
          obj?.fullname?.toLowerCase()?.includes(cond?.toLowerCase()) ||
          obj?.regNumber?.toLowerCase()?.includes(cond?.toLowerCase())
        );
      }
    });

    if (cond) return newArr;
    else return vehicles;
  };

  const handleDeleteVehicle = async (id) => {
    setLoading(true);
    try {
      await FleetServices.DeleteVehicle(id);

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

  useEffect(() => {
    setFilteredVehicles(handleSearch(vehicles, search));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [search, vehicles]);

  const columns = [
    {
      title: "Registration",
      dataIndex: "regNumber",
      render: (text, u) => (
        <Link as={"a"} to={"/fleet/" + u?.id}>
          {text}
        </Link>
      ),
      sorter: (a, b) => a?.regNumber.localeCompare(b?.regNumber),
    },
    {
      title: "Driver",
      dataIndex: "fullname",
      sorter: (a, b) => a?.fullname.localeCompare(b?.fullname),
    },
    {
      title: "Insurance Expiry",
      dataIndex: "insuranceExpiry",
      sorter: (a, b) => a?.insuranceExpiry.localeCompare(b?.insuranceExpiry),
    },
    {
      title: "Action",
      dataIndex: "action",
      render: (_, n) => {
        return (
          <Box className="flex gap-6 justify-start">
            <ActionButton handlePress={() => handleViewFleet(n)}>
              <FiEye />
            </ActionButton>

            <Popconfirm
              placement="top"
              title={`Are you sure you want to Delete ` + n?.regNumber}
              onConfirm={() => handleDeleteVehicle(n?.id)}
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

  return (
    <Box p={"3"} maxH={"91%"} overflowY={"scroll"}>
      <BreadCrumb icon={<RiCarLine />} title={"Fleet management"} />

      <HStack pt={"2"} gap={3}>
        {cards_data?.map((item) => (
          <FleetCard no={item?.number} text={item?.text} />
        ))}
      </HStack>

      <Wrapper my={"3"} px={"5"}>
        {/* search and table actions */}
        <HStack py={"3"} justifyContent={"space-between"}>
          {/* /search input */}
          <CInput
            icon={<IoSearchOutline className="text-xl" />}
            handleChange={(e) => {
              setSearch(e?.target?.value);
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
              loading={loading || stateLoading}
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
              dataSource={filteredVehicles}
            />
          </Box>
        </ConfigProvider>
      </Wrapper>
    </Box>
  );
};

export default Fleet;

// const tableData = [
//   {
//     registration: "kcb 4457k",
//     driver: "Brooke Manor",
//     "insurance expiry": "Collins joe",
//     status: 1,
//   },
// ];
// const STATUS_LIST = {
//   1: "busy",
//   2: "available",
//   0: "offline",
// };
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
    text: "total vehicles",
    number: 152,
  },
  {
    text: "online vehicles",
    number: 60,
  },
  {
    text: "on trip",
    number: 30,
  },
  {
    text: "Offline vehicles",
    number: 6,
  },
];

const FleetCard = ({ text, no }) => (
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
      <Lorry />
    </Center>
  </HStack>
);
