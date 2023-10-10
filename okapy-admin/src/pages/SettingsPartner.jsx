import { Box, Button, HStack } from "@chakra-ui/react";
import React, { useState } from "react";
import BreadCrumb from "../components/general/BreadCrumb";
import Wrapper from "../components/general/Wrapper";

import { useNavigate } from "react-router-dom";
import Categories from "../components/settings_user/Categories";
import { FiSettings } from "react-icons/fi";

const SettingsPartner = () => {
  const navigate = useNavigate();
  const [currentSubNav, setCurrent] = useState("categories"); //processing,paid

  const handleViewApplication = (name) => {
    navigate(`${name}`, name);
  };

  return (
    <Box p={"3"} maxH={"91%"} overflowY={"scroll"}>
      <BreadCrumb
        icon={<FiSettings />}
        title={"Settings/"}
        subtitle={"Partners"}
        c={"capitalize"}
      />

      <Wrapper my={"2"} p={"5 "}>
        <HStack
          gap={"2"}
          className={"border-b-2 border-zinc-200"}
          h={"12"}
          mx={"4"}
        >
          <SubNavItem
            isCurrent={currentSubNav.toLowerCase() === "categories"}
            title={"categories"}
            handleClick={() => setCurrent("categories")}
          />
        </HStack>

        {currentSubNav === "categories" && (
          <Categories handleView={handleViewApplication} />
        )}
      </Wrapper>
    </Box>
  );
};

export default SettingsPartner;

const SubNavItem = ({ title, isCurrent, handleClick }) => (
  // <Button>

  // </Button>
  <Button
    h={"12"}
    cursor={"pointer"}
    borderRadius={"none"}
    bg={"white "}
    className={`text-primary_yellow text-lg ${
      isCurrent ? "text-dark_green " : "text-zinc-400 "
    }`}
    //  onClick={handleLogout}
    _hover={{
      bg: "white",
      borderBottomColor: "dark_green",
      textColor: "dark_green",
    }}
    _focus={{ bg: "white" }}
    fontWeight={isCurrent ? "semibold" : "normal"}
    px={"6"}
    // py={"3"}
    borderBottomWidth={"2px"}
    borderBottomColor={isCurrent ? "dark_green" : "none"}
    onClick={handleClick}
  >
    {title}
  </Button>
);

export const ActionButton = ({ bg, children }) => (
  <Button
    fontSize={"lg"}
    p={"0"}
    h={"30px"}
    className={`${bg} rounded-md  text-dark_green border border-dark_green`}
  >
    {children}
  </Button>
);
