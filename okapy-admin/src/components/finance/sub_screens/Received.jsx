/* eslint-disable react-hooks/exhaustive-deps */
import { ConfigProvider, Popconfirm, Table } from "antd";
import React, { useEffect, useState } from "react";

import { Box, HStack, Text, useToast } from "@chakra-ui/react";
import _ from "lodash";
import { IoSearchOutline } from "react-icons/io5";
import { toastProps } from "../../../utils/Helper";
import EarningServices from "../../../utils/services/EarningServices";
import CInput from "../../general/Input";

const Received = ({ unPaidInvoices, loading, refetch }) => {
  const toast = useToast();

  const [earnings, setEarnings] = useState([]);
  const [filterUnpaidEarnings, setFilterUnpaidEarnings] = useState([]);
  const [searchValue, setSearchValue] = useState("");
  // const [stateLoading, setStateLoading] = useState(true);

  const fetchUnpaidEarnings = async () => {
    let arr = [];
    unPaidInvoices.forEach((element) => {
      const unpaidEarningsObj = {
        fullname:
          element?.owner?.first_name + " " + element?.owner?.last_name || "",
        amount: element?.amount || 0,
        createdAt: element?.created_at || "",
        id: element?.id,
      };
      arr.push(unpaidEarningsObj);
    });
    setEarnings(arr);
    setFilterUnpaidEarnings(arr);
  };

  useEffect(() => {
    fetchUnpaidEarnings();
  }, []);

  const handleConfirm = async (r) => {
    try {
      await EarningServices.confirmPaymentRequest(r?.id);
      refetch();

      toast({
        ...toastProps,
        title: "Success!",
        description: "Request confirmed",
        status: "success",
      });
    } catch (error) {
      toast({
        ...toastProps,
        title: "Error!",
        description: "Request not confirmed",
        status: "error",
      });
    }
  };
  const handleSearch = (arr, cond) => {
    const newArr = _.filter(arr, (obj) => {
      if (cond) {
        return (
          obj?.fullname?.toLowerCase()?.includes(cond?.toLowerCase()) ||
          obj?.createdAt?.toLowerCase()?.includes(cond?.toLowerCase())
        );
      }
    });

    if (cond) return newArr;
    else return earnings;
  };

  useEffect(() => {
    setFilterUnpaidEarnings(handleSearch(earnings, searchValue));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [earnings, searchValue]);

  const columns = [
    {
      title: "Date",
      dataIndex: "createdAt",
      sorter: (a, b) => a?.createdAt.localeCompare(b?.createdAt),
    },
    {
      title: "Name",
      dataIndex: "fullname",
      sorter: (a, b) => a?.fullname.localeCompare(b?.fullname),
    },
    {
      title: "Amount (KES)",
      dataIndex: "amount",
      // render: (text, u) => (
      //   "Ksh. " + {text}
      // ),
      sorter: (a, b) => a?.amount.localeCompare(b?.amount),
    },
    {
      title: "Action",
      dataIndex: "action",
      render: (_, n) => {
        return (
          <Box className="flex gap-4">
            <Popconfirm
              placement="top"
              title={`Are you sure you want to confirm payment?`}
              onConfirm={() => handleConfirm(n)}
              okText="Yes"
              cancelText="No"
              okButtonProps={{ type: "default" }}
              cancelButtonProps={{ type: "link", color: "red" }}
            >
              <button className="bg-primary_yellow rounded-md items-center flex gap-2 px-5 py-2">
                <Text fontWeight={"semibold"}>Confirm</Text>
              </button>
            </Popconfirm>
          </Box>
        );
      },
    },
  ];

  return (
    <>
      {/* search and table actions */}
      <HStack py={"6"} justifyContent={"space-between"} px={"4"}>
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
            dataSource={filterUnpaidEarnings}
          />
        </Box>
      </ConfigProvider>
    </>
  );
};

export default Received;

// const tableData = [
//   {
//     date: "12/5/2022",
//     name: "Brooke Manor",
//     amount: "13,000",
//   },
//   {
//     date: "12/5/2022",
//     name: "Brooke Manor",
//     amount: "13,000",
//   },
//   {
//     date: "12/5/2022",
//     name: "Brooke Manor",
//     amount: "10,000",
//   },
//   {
//     date: "12/5/2022",
//     name: "Brooke Manor",
//     amount: "13,000",
//   },
//   {
//     date: "12/5/2022",
//     name: "Brooke Manor",
//     amount: "10,000",
//   },
//   {
//     date: "12/5/2022",
//     name: "Brooke Manor",
//     amount: "18,000",
//   },
//   {
//     date: "12/5/2022",
//     name: "Brooke Manor",
//     amount: "18,000",
//   },
//   {
//     date: "12/5/2022",
//     name: "Brooke Manor",
//     amount: "10,000",
//   },
//   {
//     date: "12/5/2022",
//     name: "Brooke Manor",
//     amount: "10,000",
//   },
//   {
//     date: "12/5/2022",
//     name: "Brooke Manor",
//     amount: "10,000",
//   },
// ];
