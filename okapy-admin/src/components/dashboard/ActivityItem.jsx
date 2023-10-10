import { Box, Center, HStack, Text } from "@chakra-ui/react";
import React from "react";

const ActivityItem = ({ icon, name, number, bg }) => {
  return (
    <HStack
      p={"2"}
      className={"border-r border-zinc-200  "}
      px={"6"}
      w={"180px"}
      m={"1"}
      justifyContent={"center"}
    >
      <Center h={"16"} w={"16"} bg={bg} borderRadius={"md"}>
        {icon}
      </Center>
      <Box className="text-left ">
        <Text className="text-gray-300 text-sm">{name}</Text>
        <Text className="font-medium text-3xl">{number}</Text>
      </Box>
      `
    </HStack>
  );
};

export default ActivityItem;
