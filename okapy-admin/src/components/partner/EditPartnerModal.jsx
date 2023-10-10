import { Box, Button, Text, VStack, Checkbox } from "@chakra-ui/react";
import React, { useEffect, useState } from "react";
import CustomModal from "../general/CustomModal";
import { BsMailbox, BsPerson, BsTelephone } from "react-icons/bs";
import CInput from "../general/Input";
import Wrapper from "../general/Wrapper";
import UserServices from "../../utils/services/UserServices";

const EditPartnerModal = ({ openModal, handleCloseModal, current }) => {
  const [usersValues, setUserValues] = useState({
    first_name: "",
    last_name: "",
    is_admin: false,
    is_driver: false,
    email: "",
    phonenumber: "",
  });


  useEffect(() => {
    setUserValues((prev) => ({
      ...prev,
      first_name: current?.first_name,
      last_name: current?.last_name,
      is_admin: current?.is_admin,
      is_driver: current?.is_driver,
      email: current?.email,
      phonenumber: current?.phonenumber,
    }));
  }, [current]);

  const handleInput = (e) => {
    e.persist();
    setUserValues({ ...usersValues, [e.target.name]: e.target.value });
  }

  const handleUpdate = (e) => {
    e.preventDefault();

    const data = {
      id: current?.id,
      first_name: usersValues?.first_name,
      last_name: usersValues?.last_name,
      is_admin: usersValues?.is_admin,
      is_driver: usersValues?.is_driver,
      email: usersValues?.email,
      phonenumber: usersValues?.phonenumber,
    }
    
    try {
      UserServices.updateUser(data).then(() => {
        handleCloseModal();
      })
    }
    catch (error) {
      console.log(error.message)
    }

  }

  return (
    <CustomModal
      title={`User/${current?.first_name + " " + current?.last_name}`}
      isOpen={openModal}
      onClose={handleCloseModal}
      bg={"gray.100"}
      px={0}
      showHeader={false}
      ofy={"scroll"}
      hideSave
    >
      {/* {JSON.stringify(current)} */}
      <Wrapper className={"flex justify-end"} px={6} borderRadius={"0"}>
        <Button
          h={"30px"}
          borderRadius={"6"}
          className={"border border-yellow-400 text-yellow-400"}
          px={4}
          py={6}
          onClick={handleUpdate}
        >
          Update
        </Button>
      </Wrapper>

      {/* sender information */}
      <Box className={""}>
        <Box className="px-7 py-3" fontSize={"lg"} fontWeight={"semibold"}>
          User Information
        </Box>

        <Wrapper borderRadius={0} px={"7"}>
          <VStack gap={"0.5"} w={"full"} mx={0}>
            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>First name</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.first_name}
                icon={<BsPerson className="text-xl" />}
                borderRadius={"md"}
                name="first_name"
                onChange={handleInput}
              />
            </Box>

            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Last name</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.last_name}
                icon={<BsPerson className="text-xl" />}
                borderRadius={"md"}
                name="last_name"
                onChange={handleInput}
              />
            </Box>

            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Category</Text>

              <Box className="flex w-full gap-5">
                <Checkbox
                  isChecked={usersValues?.is_admin}
                  name="is_admin"
                  onChange={handleInput}
                  colorScheme='yellow'
                >
                  Admin roles
                </Checkbox>

                <Checkbox
                  isChecked={usersValues?.is_driver}
                  name="is_driver"
                  onChange={handleInput}
                  colorScheme='yellow'
                >
                  Driver roles
                </Checkbox>
              </Box>

            </Box>

            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Email</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.email}
                icon={<BsMailbox className="text-xl" />}
                borderRadius={"md"}
                name="email"
                onChange={handleInput}
              />
            </Box>

            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Phone</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.phonenumber}
                icon={<BsTelephone className="text-xl" />}
                borderRadius={"md"}
                name="phonenumber"
                onChange={handleInput}
              />
            </Box>

          </VStack>
        </Wrapper>
      </Box>

    </CustomModal>
  );
};

export default EditPartnerModal;
export const ActionButton = ({ bg, children, handleClick }) => (
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

