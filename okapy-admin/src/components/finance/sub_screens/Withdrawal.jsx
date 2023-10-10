import React from "react";
import Table from "../../../components/general/Table";

import { IoSearchOutline } from "react-icons/io5";
import CInput from "../../../components/general/Input";
import { AiFillCreditCard } from "react-icons/ai";
import PayButton from "../../../components/finance/PayButton";
import { Box, HStack, Text } from "@chakra-ui/react";

const Withdrawal = () => {
  return (
    <>
      {/* search and table actions */}
      <HStack py={"6"} justifyContent={"space-between"} px={"4"}>
        {/* /search input */}
        <CInput icon={<IoSearchOutline className="text-xl" />} />
        {/* pay invoices button */}
        <Box gap={"2"} textAlign={"center"}>
          {/* text */}
          <Text fontWeight={"bold"} fontSize={"xl"} mb={"2"}>
            KES. 75,000
          </Text>
          {/* button */}
          <PayButton
            icon={<AiFillCreditCard className="text-md" />}
            text={"Pay invoices"}
          />
        </Box>
      </HStack>
      {/* body */}
      <Box className="">
        <Table headers={[...Object.keys(tableData[0]), "Actions"]}>
          {tableData?.map((data, key) => {
            const isEven = key % 2;

            return (
              <tr
                className={`h-14 capitalize ${
                  isEven ? "bg-[#F9F9F9]" : "white"
                }`}
              >
                <td className="py-3 px-4">{data?.date}</td>

                <td className=" py-3 px-4">{data?.name}</td>
                <td className=" py-3 px-4">KES. {data?.amount}</td>

                {/* actions table */}
                <td className={` py-3 px-4 w-40`}>
                  <Box className="flex justify-end gap-4">
                    <PayButton
                      icon={<AiFillCreditCard className="text-lg" />}
                      text={"Pay invoices"}
                    />
                  </Box>
                </td>
              </tr>
            );
          })}
        </Table>
      </Box>
    </>
  );
};

export default Withdrawal;

const tableData = [
  {
    date: "12/5/2022",
    name: "Brooke Manor",
    amount: "10,000",
  },
  {
    date: "12/5/2022",
    name: "Brooke Manor",
    amount: "10,000",
  },
  {
    date: "12/5/2022",
    name: "Brooke Manor",
    amount: "10,000",
  },
  {
    date: "12/5/2022",
    name: "Brooke Manor",
    amount: "10,000",
  },
  {
    date: "12/5/2022",
    name: "Brooke Manor",
    amount: "10,000",
  },
  {
    date: "12/5/2022",
    name: "Brooke Manor",
    amount: "10,000",
  },
  {
    date: "12/5/2022",
    name: "Brooke Manor",
    amount: "10,000",
  },
  {
    date: "12/5/2022",
    name: "Brooke Manor",
    amount: "10,000",
  },
];
