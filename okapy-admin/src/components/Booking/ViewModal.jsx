import { Box, Button, Text, VStack } from "@chakra-ui/react";
import React, { useEffect, useState } from "react";
import { AiOutlineDelete } from "react-icons/ai";
import { BsPerson, BsTelephone } from "react-icons/bs";
import { FiMapPin } from "react-icons/fi";
import { STATUS_LIST } from "../../utils/Helper";
import CustomModal from "../general/CustomModal";
import CInput from "../general/Input";
import StatusTag from "../general/StatusTag";
import Wrapper from "../general/Wrapper";

const ViewModal = ({ openModal, handleCloseModal, current }) => {
  const [usersValues, setUserValues] = useState({
    sender: {
      name: "",
      phoneNumber: "",
      location: "",
    },
    receiver: {
      name: "",
      phoneNumber: "",
      location: "",
    },
    driver: {
      name: "",
      phoneNumber: "",
    },
    status: "",
  });

  // useEffect(() => {
  //   BookingService.fetchBookings().then((response) => {
  //     setBooking(response.find((data) => data.id === bookingId));
  //     setUserValues();
  //   });
  // }, [bookingId]);

  useEffect(() => {
    setUserValues((prev) => ({
      ...prev,
      sender: {
        name: current?.sender,
        phoneNumber: current?.senderPhoneNumber,
        location: current?.pickup,
      },

      receiver: {
        name: current?.receiver,
        phone: current?.receiverPhoneNumber,
        location: current?.destination,
      },
      driver: {
        name: current?.driver,
        phone: current?.driverPhoneNumber,
      },
      status: current?.status,
    }));
  }, [current]);

  const statusBG =
    usersValues?.status === 0
      ? "bg-primary_red"
      : usersValues?.status === 5
      ? "bg-primary_green"
      : "bg-primary_yellow_light";

  return (
    <CustomModal
      title="Booking"
      isOpen={openModal}
      onClose={handleCloseModal}
      bg={"gray.100"}
      px={0}
      showHeader={false}
      ofy={"scroll"}
      hideSave
    >
      {/* {JSON.stringify(current)} */}
      <Wrapper className={"flex gap-8 items-center"} px={6} borderRadius={"0"}>
        <Text fontSize={"sm"}>Status</Text>

        <Box className={"flex-grow flex"}>
          <StatusTag
            bg={statusBG}
            status={
              <Text textTransform={"capitalize"} textColor={"white"}>
                {STATUS_LIST[usersValues?.status]}
              </Text>
            }
          />
        </Box>

        <Button
          h={"30px"}
          borderRadius={"0"}
          className={"border border-red-600"}
          px={1}
        >
          <AiOutlineDelete className="text-xl text-red-600" />
        </Button>
      </Wrapper>

      {/* sender information */}
      <Box className={""}>
        <Box className="px-7 py-3" fontSize={"lg"} fontWeight={"semibold"}>
          Sender Information
        </Box>

        <Wrapper borderRadius={0} px={"7"}>
          <VStack gap={"0.5"} w={"full"} mx={0}>
            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Name</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.sender?.name}
                icon={<BsPerson className="text-xl" />}
                borderRadius={"md"}
              />
            </Box>

            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Phone</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.sender?.phoneNumber}
                icon={<BsTelephone className="text-xl" />}
                borderRadius={"md"}
              />
            </Box>

            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Pickup Location</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.sender?.location}
                icon={<FiMapPin className="text-xl" />}
                borderRadius={"md"}
              />
            </Box>
          </VStack>
        </Wrapper>
      </Box>

      {/* receiver information */}
      <Box className={""}>
        <Box className="px-7 py-3" fontSize={"lg"} fontWeight={"semibold"}>
          Receiver Information
        </Box>

        <Wrapper borderRadius={0} px={"7"}>
          <VStack gap={"0.5"} w={"full"} mx={0}>
            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}> Name</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.receiver?.name}
                icon={<BsPerson className="text-xl" />}
                borderRadius={"md"}
              />
            </Box>

            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Phone</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.receiver?.phone}
                icon={<BsTelephone className="text-xl" />}
                borderRadius={"md"}
              />
            </Box>

            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Pickup Location</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.receiver?.location}
                icon={<FiMapPin className="text-xl" />}
                borderRadius={"md"}
              />
            </Box>
          </VStack>
        </Wrapper>
      </Box>

      {/* driver information */}
      <Box className={""}>
        <Box className="px-7 py-3" fontSize={"lg"} fontWeight={"semibold"}>
          Driver Information
        </Box>

        <Wrapper borderRadius={0} px={"7"}>
          <VStack gap={"0.5"} w={"full"} mx={0}>
            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Driver name</Text>

              {/* {JSON.stringify(usersValues?.driver)} */}

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.driver?.name || ""}
                icon={<BsPerson className="text-xl" />}
                borderRadius={"md"}
              />
            </Box>

            <Box className="flex w-full flex-col gap-1">
              <Text fontSize={"sm"}>Phone</Text>

              <CInput
                h={"10"}
                w={3 / 4}
                placeholder=""
                value={usersValues?.driver?.phone}
                icon={<BsTelephone className="text-xl" />}
                borderRadius={"md"}
              />
            </Box>
          </VStack>
        </Wrapper>
      </Box>
    </CustomModal>
  );
};

export default ViewModal;
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
