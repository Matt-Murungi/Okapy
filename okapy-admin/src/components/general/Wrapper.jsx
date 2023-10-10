import { Box } from "@chakra-ui/react";
import React from "react";

const Wrapper = ({ children, ...rest }) => {
  return (
    <Box borderRadius={"xl"} bg={"white"} p={"3"} {...rest}>
      {children}
    </Box>
  );
};

export default Wrapper;
