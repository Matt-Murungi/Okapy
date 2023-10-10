import { Box, Center, HStack, Text } from "@chakra-ui/react";
import React from "react";
import { Finance } from "../../assets/svg";

const FinanceCard = ({ text, no }) => (
  <HStack
    fontFamily={"Poppins"}
    bg={"white"}
    borderRadius={"xl"}
    h={"28"}
    w={1 / 4}
    px={"5"}
  >
    <Box className="flex-grow">
      <Text fontSize={"sm"} className={"text-zinc-400"}>
        {text}
      </Text>
      <Text mt={"1"} fontWeight={"700"} fontSize={"25px"}>
        KES. {no}
      </Text>
    </Box>

    <Center p={"2"} bg={"current_bg"} borderRadius={"md"}>
      <Finance />
    </Center>
  </HStack>
);

export default FinanceCard;
