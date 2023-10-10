import React, { useState, useEffect } from "react";
import { ConfigProvider, Table } from "antd";

import { Link } from "react-router-dom";
import { IoSearchOutline } from "react-icons/io5";
import CInput from "../../general/Input";
import { Box, Button, HStack } from "@chakra-ui/react";
import _ from "lodash";
import { FiEye } from "react-icons/fi";
import UserServices from "../../../utils/services/UserServices";

const Accepted = ({ handleView }) => {
  const [applications, setApplications] = useState();
  const [filterAcceptedApplication, setFilterAcceptedApplication] = useState(
    []
  );
  const [stateLoading, setStateLoading] = useState(true);
  const [searchValue, setSearchValue] = useState("");

  React.useEffect(() => {
    UserServices.fetchDrivers(true).then((response) => {
      let arr = [];
      response.forEach((element) => {
        const pendingApplicationObj = {
          fullname:
            element?.user?.first_name + " " + element?.user?.last_name || "",
          phone: element?.user?.phonenumber || "",
          email: element?.user?.email || "",
          dateJoined: element?.user?.date_joined || "",
          id: element?.id,
          uid: element?.user?.id,
        };
        arr.push(pendingApplicationObj);
      });
      setApplications(arr);
      setFilterAcceptedApplication(arr);
      setStateLoading(false);
    });
  }, []);

  const handleSearch = (arr, cond) => {
    const newArr = _.filter(arr, (obj) => {
      if (cond) {
        return (
          obj?.fullname?.toLowerCase()?.includes(cond?.toLowerCase()) ||
          obj?.phone?.toLowerCase()?.includes(cond?.toLowerCase()) ||
          obj?.email?.toLowerCase()?.includes(cond?.toLowerCase())
        );
      }
    });

    if (cond) return newArr;
    else return applications;
  };

  useEffect(() => {
    setFilterAcceptedApplication(handleSearch(applications, searchValue));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [applications, searchValue]);

  const columns = [
    {
      title: "Fullname",
      dataIndex: "fullname",
      render: (text, u) => (
        <Link as={"a"} to={"/applications/" + u?.id}>
          {text}
        </Link>
      ),
      sorter: (a, b) => a?.fullname.localeCompare(b?.fullname),
    },
    {
      title: "Phone",
      dataIndex: "phone",
      sorter: (a, b) => a?.phone.localeCompare(b?.phone),
    },
    {
      title: "Email",
      dataIndex: "email",
      sorter: (a, b) => a?.email.localeCompare(b?.email),
    },
    {
      title: "Accepted Date",
      dataIndex: "dateJoined",
      sorter: (a, b) => a?.dateJoined.localeCompare(b?.dateJoined),
    },
    {
      title: "Action",
      dataIndex: "action",
      render: (_, n) => {
        return (
          <Box className="flex gap-6 justify-start">
            <ActionButton handleClick={() => handleView(n?.uid)}>
              <FiEye />
            </ActionButton>
          </Box>
        );
      },
    },
  ];

  return (
    <>
      {/* search and table actions */}
      <HStack py={"3"} justifyContent={"space-between"}>
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
            dataSource={filterAcceptedApplication}
          />
        </Box>
      </ConfigProvider>
    </>
  );
};

export default Accepted;

// const tableData = [
//   {
//     fullname: "New User",
//     phone: "0711223344",
//     email: "brook@okapy.com",
//     // vehicle_cat: "Cab",
//     "accepted date": new Date().toLocaleString(),
//   },
//   {
//     fullname: "New User",
//     phone: "0711223344",
//     email: "brook@okapy.com",
//     vehicle_cat: "Truck",
//     "accepted date": new Date().toLocaleString(),
//   },
//   {
//     fullname: "New User",
//     phone: "0711223344",
//     email: "brook@okapy.com",
//     vehicle_cat: "Truck",
//     "accepted date": new Date().toLocaleString(),
//   },
//   {
//     fullname: "New User",
//     phone: "0711223344",
//     email: "brook@okapy.com",
//     vehicle_cat: "Cab",
//     "accepted date": new Date().toLocaleString(),
//   },
//   {
//     fullname: "New User",
//     phone: "0711223344",
//     email: "brook@okapy.com",
//     vehicle_cat: "Cab",
//     "accepted date": new Date().toLocaleString(),
//   },
//   {
//     fullname: "New User",
//     phone: "0711223344",
//     email: "brook@okapy.com",
//     vehicle_cat: "Motorbike",
//     "accepted date": new Date().toLocaleString(),
//   },
//   {
//     fullname: "New User",
//     phone: "0711223344",
//     email: "brook@okapy.com",
//     vehicle_cat: "Motorbike",
//     "accepted date": new Date().toLocaleString(),
//   },
//   {
//     fullname: "New User",
//     phone: "0711223344",
//     email: "brook@okapy.com",
//     vehicle_cat: "Cab",
//     "accepted date": new Date().toLocaleString(),
//   },
// ];

export const ActionButton = ({ bg, children, handleClick }) => (
  <Button
    onClick={handleClick}
    fontSize={"lg"}
    p={"0"}
    h={"30px"}
    className={`${bg} rounded-md  text-dark_green border border-dark_green`}
  >
    {children}
  </Button>
);
