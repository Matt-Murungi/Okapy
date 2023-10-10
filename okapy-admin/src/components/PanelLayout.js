import { Box } from "@chakra-ui/react";
import React, { useContext, useEffect, useState } from "react";
import SideNav from "./general/SideNav";
import TopNav from "./general/TopNav";
import AuthService from "../auth/services/AuthServices";
import { UserContext } from "../App";

const PanelLayout = ({ children }) => {
  const { setCurrentUser } = useContext(UserContext);

  const [showSideBar, setShowSideBar] = useState(true);
  const handleToggle = () => {
    setShowSideBar((prev) => !prev);
  };

  useEffect(() => {
    AuthService.getUser().then(async (response) => {
      setCurrentUser(response);
    });
  }, []);
  return (
    <Box display={"flex"} flexDir={"row"} bg={"bg_gray"} className={"h-screen"}>
      <SideNav show={showSideBar} />

      <Box minH={"full"} w={"100%"} ml={0}>
        <TopNav toggleSideBar={handleToggle} />
        {children}
      </Box>
    </Box>
  );
};

export default PanelLayout;
