import { Spinner } from "@chakra-ui/react";
import React from "react";
import "./loader.css";

const Loader = () => {
  return (
    <div class="fixed top-0 left-0 right-0 bottom-0 w-full h-screen z-50 overflow-hidden bg-[#dfdfdfA0] opacity-75 flex flex-col items-center justify-center">
      <Spinner
        thickness="4px"
        speed="0.5s"
        emptyColor="gray.200"
        color="primary_yellow"
        size="xl"
      />
    </div>
  );
};

export default Loader;
