import { Text } from "@chakra-ui/react";
import React from "react";

const OutlinedButton = ({ icon, text }) => {
  return (
    <button className="text-primary_yellow border-[1.5px] border-primary_yellow rounded-md items-center flex gap-2 px-2 py-1">
      {icon}
      <Text fontWeight={"semibold"}>{text}</Text>
    </button>
  );
};

export default OutlinedButton;
