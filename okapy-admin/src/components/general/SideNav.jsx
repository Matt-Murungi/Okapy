import { Box, Center, HStack, Text, useToast, VStack } from "@chakra-ui/react";
import React, { useState } from "react";
import { BiIdCard } from "react-icons/bi";
import { BsPeople } from "react-icons/bs";
import { FaPeopleArrows } from "react-icons/fa";
import { GoGraph } from "react-icons/go";
import { MdOutlineDashboard } from "react-icons/md";
import { RiCarLine } from "react-icons/ri";
import { TiClipboard } from "react-icons/ti";
import { useNavigate } from "react-router-dom";
import { Logo } from "../../assets/svg";
import { toastProps } from "../../utils/Helper";
import useUserStore from "../../utils/zustand/Store";
import LogoutBtn from "../sidenav/LogoutBtn";

const SideNav = ({ show }) => {
  const navigate = useNavigate();
  const toast = useToast();
  const [current, setCurrent] = useState("dashboard");
  const [currentSub, setCurrentSub] = useState("users");

  const handleCurrent = (selected, to) => {
    setCurrent(selected.toLowerCase());
    if (to !== "settings") navigate(to);
  };
  const handleSelectCurrentSub = (selected, to) => {
    setCurrentSub(selected.toLowerCase());
    navigate(to);
  };

  const setToken = useUserStore((state) => state.setToken);
  const handleLogout = async () => {
    setToken("");

    // AuthServices.logout().then((response) => {
    toast({
      ...toastProps,
      title: "Success",
      description: "Logged out admin!",
      status: "success",
    });
    //   setTimeout(() => {
    //     // eslint-disable-next-line no-restricted-globals
    //     location.reload();
    //   }, 2000);
    // });
  };

  return (
    <Box
      w={"200px"}
      bg={"white"}
      className={`h-screen ${!show && "hidden"} ease-in-out `}
      flexShrink={0}
    >
      {/* Logo */}
      <Center h={"150px"}>
        <Logo />
      </Center>

      <VStack gap={"1"} p={"2"} h={"70%"}>
        {menu_list.map((menu, key) => (
          <MenuItem
            key={key}
            icon={menu.icon}
            title={menu.name}
            isCurrent={menu.name.toLowerCase() === current}
            handleClick={() => handleCurrent(menu.name, menu?.to)}
            hasSubs={menu?.hasSub}
            subs={menu?.subs}
            currentSub={currentSub}
            handleSelectCurrentSub={handleSelectCurrentSub}
          />
        ))}
      </VStack>

      <Box p={"3"}>
        <LogoutBtn handleLogout={handleLogout} />
      </Box>
    </Box>
  );
};

export default SideNav;

const MenuItem = ({
  icon,
  title,
  isCurrent,
  handleClick,
  hasSubs,
  subs,
  currentSub,
  handleSelectCurrentSub,
}) => (
  <Box w={"full"}>
    <Box
      cursor={"pointer"}
      borderRadius={"md"}
      bg={isCurrent ? "current_bg" : "white"}
      className={isCurrent ? "text-dark_green" : "text-zinc-400"}
      w={"full"}
      onClick={handleClick}
      _hover={{
        color: "dark_green",
        bg: "current_bg",
      }}
    >
      <HStack gap={"2"} h={"10"} px={2}>
        {/* icon */}
        <Center
          h={"5"}
          w={"5"}
          textColor={isCurrent ? "text-dark_green" : "text-zinc-400"}
          fontSize={"lg"}
          // className={}
        >
          {icon}
        </Center>

        {/* name */}
        <Text fontSize={"sm"}>{title}</Text>
      </HStack>
    </Box>

    <Box className={"w-11/12 pl-3 "} float={"right"}>
      {isCurrent &&
        hasSubs &&
        subs?.map((sub, key) => (
          <SubMenu
            key={key}
            icon={sub?.icon}
            title={sub?.name}
            isCurrent={sub?.name.toLowerCase() === currentSub}
            handleClick={() => handleSelectCurrentSub(sub?.name, sub?.to)}
          />
        ))}
    </Box>
  </Box>
);

const SubMenu = ({ isCurrent, handleClick, icon, title }) => (
  <Box
    cursor={"pointer"}
    borderRadius={"md"}
    // bg={isCurrent ? "current_bg" : "white"}
    className={isCurrent ? "text-dark_green" : "text-zinc-400"}
    w={"full"}
    onClick={handleClick}
    _hover={{
      color: "dark_green",
      //   bg: "current_bg",
    }}
  >
    <HStack gap={"2"} h={"10"} px={2}>
      {/* icon */}
      <Center
        h={"5"}
        w={"5"}
        textColor={isCurrent ? "text-dark_green" : "text-zinc-400"}
        fontSize={"lg"}
        // className={}
      >
        {icon}
      </Center>

      {/* name */}
      <Text fontSize={"sm"}>{title}</Text>
    </HStack>
  </Box>
);
const menu_list = [
  {
    name: "Dashboard",
    to: "/",
    icon: <MdOutlineDashboard />,
  },
  {
    name: "Bookings",
    to: "/bookings",
    icon: <TiClipboard />,
  },
  {
    name: "Fleet Management",
    to: "/fleet",
    icon: <RiCarLine />,
  },
  {
    name: "Finance",
    to: "/finance",
    icon: <GoGraph />,
  },
  {
    name: "Applications",
    to: "/applications",
    icon: <BiIdCard />,
  },
  {
    name: "User Management",
    to: "/users",
    icon: <BsPeople />,
  },
  {
    name: "Partners",
    to: "/partners",
    icon: <FaPeopleArrows />,
  },
  // {
  //   name: "Settings",
  //   icon: <FiSettings />,
  //   hasSub: true,
  //   subs: [
  //     {
  //       name: "Users",
  //       to: "/settings/users",
  //       icon: <BsPeople />,
  //     },
  //     {
  //       name: "Partners",
  //       to: "/settings/partners",
  //       icon: <FaPeopleArrows />,
  //     },
  //   ],
  // },
];