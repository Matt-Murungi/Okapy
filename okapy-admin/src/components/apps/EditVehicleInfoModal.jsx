import { Box, Button, Text, VStack } from "@chakra-ui/react";
import React, { useEffect, useState } from "react";
import FleetServices from "../../utils/services/FleetServices";
import CustomModal from "../general/CustomModal";
import CInput, { CSelect } from "../general/Input";
import Wrapper from "../general/Wrapper";

const EditVehicleModal = ({ openModal, handleCloseModal, current }) => {
  const [usersValues, setUserValues] = useState({
    reg_number: "",
    color: "",
    vehicle_type: "",
    model: "",
  });

  useEffect(() => {
    setUserValues((prev) => ({
      ...prev,
      reg_number: current?.reg_number,
      color: current?.color,
      vehicle_type: current?.vehicle_type,
      model: current?.model,
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
      reg_number: usersValues?.reg_number,
      color: usersValues?.color,
      vehicle_type: parseInt(usersValues?.vehicle_type),
      model: usersValues?.model,
      owner: parseInt(current?.owner),
    }

    try {
      FleetServices.updateDriverVehicle(data).then(() => {
        handleCloseModal()
      })
    }
    catch (error) {
      console.log(error.message)
    }
  }

  return (
    <CustomModal
      title={`Vehicle Information/${current?.reg_number}`}
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
          Vehicle Information
        </Box>

        <Wrapper borderRadius={0} px={"7"}>
          <VStack gap={"0.5"} w={"full"} mx={0}>
            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Registration Number</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.reg_number}
                borderRadius={"md"}
                name="reg_number"
                onChange={handleInput}
              />
            </Box>

            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Color</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.color}
                borderRadius={"md"}
                name="color"
                onChange={handleInput}
              />
            </Box>

            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Vehicle type</Text>

              <CSelect
                h={"10"}
                w={3 / 4}
                placeholder=""
                // value={vehicle_types[usersValues?.vehicle_type]}
                borderRadius={"md"}
                onChange={handleInput}
              >
                <option value={usersValues?.vehicle_type}>{vehicle_types[usersValues?.vehicle_type]}</option>
                {vehicle_types?.map((vehicle_type, index) =>
                  <option key={index} value={index}>{vehicle_type}</option>
                )}
              </CSelect>
            </Box>

            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Model</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.model}
                borderRadius={"md"}
                onChange={handleInput}
              />
            </Box>
          </VStack>
        </Wrapper>
      </Box>

    </CustomModal>
  );
};

export default EditVehicleModal;
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

const vehicle_types = ["Motorbike", "Vehicle", "Van", "Truck"];
