import React, { useEffect, useState } from "react";
import { ConfigProvider, Table } from "antd";

import _ from "lodash";
import { IoSearchOutline } from "react-icons/io5";
import CInput from "../../general/Input";
import { Box, HStack } from "@chakra-ui/react";
import OutlinedButton from "../../general/OutlinedButton";
import { RiDeleteBin6Line } from "react-icons/ri";
import EarningServices from "../../../utils/services/EarningServices";

const Unpaid = () => {
  const [earnings, setEarnings] = useState([]);
  const [filterUnpaidEarnings, setFilterUnpaidEarnings] = useState([]);
  const [searchValue, setSearchValue] = useState("");
  const [stateLoading, setStateLoading] = useState(true);

  useEffect(() => {
    EarningServices.fetchRequestEarnings().then((response) => {
      let arr = [];
      response.filter((data) => data.status === 1).forEach((element) => {
        const unpaidEarningsObj = {
          fullname: element?.owner?.first_name + " " + element?.owner?.last_name || "",
          amount: element?.amount || 0,
          createdAt: element?.created_at || "",
          id: element?.id,
        };
        arr.push(unpaidEarningsObj)
      });
      setEarnings(arr);
      setFilterUnpaidEarnings(arr);
      setStateLoading(false)
    });
  }, []);

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
    setFilterUnpaidEarnings(handleSearch(earnings, searchValue))
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
      title: "Amount",
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
            <OutlinedButton
              icon={<RiDeleteBin6Line className="text-xl" />}
              text={"Cancel"}
            />
          </Box>
        )
      }
    }
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
            dataSource={filterUnpaidEarnings}
          />
        </Box>
      </ConfigProvider>
    </>
  );
};

export default Unpaid;

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
