import { Box } from "@chakra-ui/react";
import React from "react";

const StatusTag = ({ bg, status }) => {
  return (
    <Box
      py={"0.5"}
      h={6}
      px={"3"}
      fontSize={"xs"}
      className={`${bg} rounded-md   `}
    >
      {status}
    </Box>
  );
};

export default StatusTag;
