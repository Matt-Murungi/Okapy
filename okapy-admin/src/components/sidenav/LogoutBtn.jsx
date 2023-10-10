import { Button, Center, HStack, Text } from "@chakra-ui/react";
import React from "react";
import { FiLogOut } from "react-icons/fi";

const LogoutBtn = ({ handleLogout }) => {
  return (
    <Button
      cursor={"pointer"}
      borderRadius={"md"}
      bg={"current_bg"}
      className={"text-primary_yellow text-xl hover:scale-95"}
      w={"full"}
      onClick={handleLogout}
      _hover={{ bg: "current_bg" }}
      _focus={{ bg: "current_bg" }}
    >
      <HStack gap={"2"} h={"12"} px={2}>
        {/* icon */}
        <Center
          h={"5"}
          w={"5"}
          textColor={"primary_yellow"}
          fontSize={"2xl"}
          // className={}
        >
          <FiLogOut />
        </Center>

        {/* name */}
        <Text fontSize={"md"} fontWeight={"semibold"}>
          Logout
        </Text>
      </HStack>
    </Button>
  );
};

export default LogoutBtn;
