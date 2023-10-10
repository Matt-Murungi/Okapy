import { Button } from "@chakra-ui/react";
import React from "react";

const LoadingButton = ({ ...rest }) => {
  return (
    <Button
      isLoading
      loadingText="Loading"
      borderColor={"primary_yellow"}
      textColor={"#1A411D"}
      variant="outline"
      spinnerPlacement="end"
      {...rest}
    >
      Continue
    </Button>
  );
};

export default LoadingButton;
