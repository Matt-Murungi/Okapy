import React, { useState } from "react";
import Table from "../general/Table";

import { IoSearchOutline } from "react-icons/io5";
import CInput from "../general/Input";
import { Box, Button, HStack, Text, VStack } from "@chakra-ui/react";

import { FiEye } from "react-icons/fi";
import { VscFilter } from "react-icons/vsc";
import { BiSort } from "react-icons/bi";
import { RiDeleteBin5Line } from "react-icons/ri";
import PrimaryButton from "../general/PrimaryButton";
import { GrAdd } from "react-icons/gr";
import CustomModal from "../general/CustomModal";

const Categories = ({ handleView }) => {
  const [openModal, setOpenModal] = useState(false);

  return (
    <>
      {/* search and table actions */}
      <HStack py={"5"} justifyContent={"space-between"}>
        {/* /search input */}
        <CInput icon={<IoSearchOutline className="text-xl" />} />
        {/* actions */}
        <HStack gap={"2"}>
          <TableAction
            icon={<VscFilter className="text-lg" />}
            text={"Filter"}
          />
          <TableAction icon={<BiSort className="text-lg" />} text={"Sort"} />

          <CustomModal
            title={"Add Category"}
            isOpen={openModal}
            onClose={() => setOpenModal(false)}
            button={
              <PrimaryButton
                className={"text-sm items-end"}
                handleClick={() => setOpenModal(true)}
              >
                <GrAdd className="text-lg" />
                <Text fontWeight={"medium"}>Add Category</Text>
              </PrimaryButton>
            }
          >
            <VStack gap={"2"} w={"full"}>
              <Box className="flex w-full flex-col gap-1">
                <Text fontSize={"sm"}>Category</Text>

                <CInput h={"10"} w={3 / 4} placeholder="" borderRadius={"md"} />
              </Box>
            </VStack>
          </CustomModal>
        </HStack>
      </HStack>

      {/* body */}
      <Box>
        <Table
          headerClass="text-start"
          headers={[...Object.keys(tableData[0]), "Actions"]}
        >
          {tableData?.map((data, key) => {
            const isEven = key % 2;

            return (
              <tr
                className={`h-14 capitalize ${
                  isEven ? "bg-[#F9F9F9]" : "white"
                }`}
              >
                <td className=" text-left py-3 px-4">
                  {data?.["category name"]}
                </td>
                {/* actions table */}
                <td className={` text-white py-3 px-4 w-32 `}>
                  <Box className="flex gap-5 ">
                    <ActionButton
                      handleClick={() => handleView(data?.fullname)}
                    >
                      <FiEye />
                    </ActionButton>

                    <ActionButton>
                      <RiDeleteBin5Line />
                    </ActionButton>
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

export default Categories;

const tableData = [
  {
    "category name": "new",
  },
  {
    "category name": "new",
  },
  {
    "category name": "new",
  },
  {
    "category name": "other",
  },
  {
    "category name": "other",
  },
  {
    "category name": "other",
  },
  {
    "category name": "new",
  },
  {
    "category name": "new",
  },
];

export const ActionButton = ({ bg, children, handleClick }) => (
  <Button
    fontSize={"lg"}
    p={"0"}
    h={"30px"}
    onClick={handleClick}
    className={`${bg} rounded-md  text-dark_green border border-dark_green`}
  >
    {children}
  </Button>
);
const TableAction = ({ icon, text }) => (
  <button className="bg-zinc-200 px-3 py-1.5 gap-1 rounded-md text-sm capitalize flex  ">
    {icon}
    {text}
  </button>
);
