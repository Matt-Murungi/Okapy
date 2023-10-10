import { Box, Text } from "@chakra-ui/react";
import React, { useContext } from "react";
import { UserContext } from "../../App";

const Breadcrumb = () => {
  const { currentUser } = useContext(UserContext);

  return (
    <Box p={"1"}>
      <Text fontWeight={"semibold"} className={"text-xl"}>
        Hi {currentUser?.first_name},
      </Text>

      <Text className={"text-sm"}>Have a look at today’s activities</Text>

      <Box className="rounded-full bg-zinc-200 h-0.5 mt-2" />
    </Box>
  );
};

export default Breadcrumb;
