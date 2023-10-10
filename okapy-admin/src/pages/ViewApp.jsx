import { Box, Image, Text } from "@chakra-ui/react";
import React from "react";
import { BiIdCard } from "react-icons/bi";
import { GrEdit } from "react-icons/gr";
import { useLocation } from "react-router-dom";
import BreadCrumb from "../components/general/BreadCrumb";
import Wrapper from "../components/general/Wrapper";
import { ActionButton } from "./Apps";
import License from "../assets/images/license.png";
import Insurance from "../assets/images/certificate.png";
import RejectModal from "../components/apps/RejectModal";
import UserServices from "../utils/services/UserServices";
import EditPersonalInfoModal from "../components/apps/EditPesonalInfoModal";

const ViewApp = () => {
  const location = useLocation()?.pathname.split("/");
  const [openModal, setOpenModal] = React.useState(false);
  const [current, setCurrent] = React.useState({});
  const [user, setUser] = React.useState({});

  let userId = parseInt(location[location?.length - 1]);
  React.useEffect(() => {
    UserServices.fetchUsers().then((response) => {
      setUser(response.find((user) => parseInt(user.id) === parseInt(userId)));
    });

    // BookingServices.ownersBookings(userFirstName).then((response) => {
    //   setUserBookings(response);
    // });
  }, [userId]);

  const handleOpenModal = React.useCallback(() => {
    setOpenModal(true);
  }, []);

  const handleCloseModal = React.useCallback(() => {
    setOpenModal(false);
  }, []);

  return (
    <>
      <Box p={"3"} maxH={"91%"} overflowY={"scroll"}>
        <BreadCrumb
          icon={<BiIdCard />}
          title={`Applications /`}
          subtitle={user?.first_name}
          c={"capitalize"}
        />
        <Box className="flex gap-3">
          <Box className="w-1/3">
            <Wrapper
              my={"4"}
              p={"5"}
              borderRadius={"none"}
              className={"flex flex-col justify-center items-center rounded"}
            >
              {/* body */}
              <Box
                className="rounded-full overflow-hidden"
                h={40}
                w={40}
                bg={"gray.300"}
                mb={"3"}
              >
                <Image h={"full"} objectFit={"cover"} src={user?.image} />
              </Box>
              <Text
                fontSize={"xl"}
                textTransform={"uppercase"}
                fontWeight={"semibold"}
              >
                {location[location?.length - 1]}
              </Text>

              <Text fontSize={"sm"} fontWeight={"light"}>
                {user?.first_name} {user?.last_name}
              </Text>
            </Wrapper>

            {/* Personal information*/}
            <Box>
              <Box className="flex justify-between py-2 px-5">
                <Text fontSize={"lg"} fontWeight={"medium"}>
                  Personal information
                </Text>

                <ActionButton
                  onClick={() => {
                    setCurrent({
                      first_name: user?.first_name,
                      last_name: user?.last_name,
                      is_admin: user?.is_admin,
                      is_driver: user?.is_driver,
                      email: user?.email,
                      phone_number: user?.phonenumber,
                    });
                    handleOpenModal();
                  }}
                >
                  <GrEdit />
                </ActionButton>
              </Box>
              <Wrapper
                my={"2"}
                p={"10"}
                borderRadius={"none"}
                className={"flex justify-center items-center gap-3 text-[14px]"}
              >
                <Box className="text-right flex flex-col gap-4">
                  <Text fontWeight={"medium"}>Full name</Text>
                  <Text fontWeight={"medium"}>Category</Text>
                  <Text fontWeight={"medium"}>Location</Text>
                  <Text fontWeight={"medium"}>Email</Text>
                  <Text fontWeight={"medium"}>Phone number</Text>
                  <Text fontWeight={"medium"}>Onboarding date</Text>
                  <Text fontWeight={"medium"}>Last edit date</Text>
                </Box>

                <div className={"bg-zinc-200 h-60 w-0.5 rounded-full"} />

                <Box className="text-left flex flex-col gap-4">
                  <Text>
                    {user?.first_name} {user?.last_name}
                  </Text>
                  <Text>
                    {user?.is_admin
                      ? "Admin"
                      : user?.is_driver
                      ? "Driver"
                      : "User"}
                  </Text>
                  <Text>Nairobi CBD, Nairobi</Text>
                  <Text>{user?.email}</Text>
                  <Text>{user?.phonenumber}</Text>
                  <Text>{user?.date_joined}</Text>
                  <Text>3/10/2022</Text>
                </Box>
              </Wrapper>
            </Box>

            {/* vehicle information */}
            <Box>
              <Box className="flex justify-between py-2 px-5">
                <Text fontWeight={"medium"}>Vehicle information</Text>

                <ActionButton
                  onClick={() => {
                    setCurrent({
                      first_name: user?.first_name,
                      last_name: user?.last_name,
                      is_admin: user?.is_admin,
                      is_driver: user?.is_driver,
                      email: user?.email,
                      phone_number: user?.phonenumber,
                    });
                    handleOpenModal();
                  }}
                >
                  <GrEdit />
                </ActionButton>
              </Box>
              <Wrapper
                my={"2"}
                p={"5"}
                borderRadius={"none"}
                className={"flex justify-center items-center gap-3 text-sm"}
              >
                <Box className="text-right flex flex-col gap-4">
                  <Text fontWeight={"medium"}>Reg no</Text>
                  <Text fontWeight={"medium"}>Color</Text>
                  <Text fontWeight={"medium"}>Type</Text>
                  <Text fontWeight={"medium"}>Model</Text>
                  <Text fontWeight={"medium"}>License Expiry</Text>
                </Box>

                <div className={"bg-zinc-200 h-40 w-0.5 rounded-full"} />

                <Box className="text-left flex flex-col gap-4">
                  <Text>KCB 121G</Text>
                  <Text>Gray</Text>
                  <Text>Cab</Text>
                  <Text>Toyota Allion</Text>
                  <Text>3/9/2022</Text>
                </Box>
              </Wrapper>
            </Box>
          </Box>

          <Box className="w-2/3  my-3">
            <Wrapper w={"full"}>
              <Box>
                {/* title */}
                <Text fontSize={"lg"} fontWeight={"semibold"}>
                  License
                </Text>

                <Box p={"4"}>
                  <Image src={License} alt={"license"} h={"150px"} />
                </Box>

                <hr className="my-2" />

                <Text fontSize={"lg"} fontWeight={"semibold"}>
                  Insurance Document
                </Text>

                <Box p={"2"}>
                  <Image src={Insurance} alt={"license"} h={"540px"} />
                </Box>
              </Box>

              <Box className="flex gap-4 justify-end">
                <button
                  onClick={handleOpenModal}
                  className="text-primary_yellow border-[1.5px] border-primary_yellow rounded-md items-center flex gap-2 px-16 py-3"
                >
                  <Text fontWeight={"semibold"}>Reject</Text>
                </button>

                <button className="bg-primary_yellow rounded-md items-center flex gap-2 px-16 py-3">
                  <Text fontWeight={"semibold"}>Approve</Text>
                </button>
              </Box>
            </Wrapper>
          </Box>
        </Box>
      </Box>

      <EditPersonalInfoModal
        openModal={openModal}
        handleCloseModal={handleCloseModal}
        current={current}
      />

      <RejectModal handleCloseModal={handleCloseModal} openModal={openModal} />
    </>
  );
};

export default ViewApp;
