import { Box, Image, Text, useToast } from "@chakra-ui/react";
import React, { useEffect, useState } from "react";
import { BiIdCard } from "react-icons/bi";
import { GrEdit } from "react-icons/gr";
import { useLocation } from "react-router-dom";
import RejectModal from "../components/apps/RejectModal";
import BreadCrumb from "../components/general/BreadCrumb";
import LoadingButton from "../components/general/LoadingButton";
import Wrapper from "../components/general/Wrapper";
import { toastProps } from "../utils/Helper";
import auth from "../auth/services/AuthServices";
import FleetServices from "../utils/services/FleetServices";
import UserServices from "../utils/services/UserServices";
import { ActionButton } from "./Apps";
import EditPersonalInfoModal from "../components/apps/EditPesonalInfoModal";
import EditVehicleModal from "../components/apps/EditVehicleInfoModal";

const ViewDriver = () => {
  const location = useLocation()?.pathname.split("/");
  const [openPersonalInfoModal, setOpenPersonalInfoModal] =
    React.useState(false);
  const [openVehicleInfoModal, setOpenVehicleInfoModal] = React.useState(false);
  const [openRejectModal, setOpenRejectModal] = React.useState(false);
  const [current, setCurrent] = React.useState({});
  const [user] = useState({});
  const [vehicle, setVehicle] = useState({});
  const [driverProfile, setDriverProfile] = useState({});
  const [bankDetails, setBankDetails] = useState({});
  const toast = useToast();
  const [loading, setLoading] = useState(false);

  let profileId = location[location?.length - 1];

  const handleEditPersonalInfoOpenModal = React.useCallback(() => {
    setOpenPersonalInfoModal(true);
  }, []);

  const handleEditPersonalInfoCloseModal = React.useCallback(() => {
    setOpenPersonalInfoModal(false);
  }, []);

  const handleEditVehicleInfoOpenModal = React.useCallback(() => {
    setOpenVehicleInfoModal(true);
  }, []);

  const handleEditVehicleInfoCloseModal = React.useCallback(() => {
    setOpenVehicleInfoModal(false);
  }, []);

  const handleRejectOpenModal = React.useCallback(() => {
    setOpenRejectModal(true);
  }, []);

  const handleRejectCloseModal = React.useCallback(() => {
    setOpenRejectModal(false);
  }, []);

  useEffect(() => {
    // UserServices.fetchUsers().then((response) => {
    //   setUser(response.find((user) => user.id === parseInt(profileId)));
    // });
    auth.getProfiles().then(async (response) => {
      setDriverProfile(
        response.find((user) => user.id === parseInt(profileId))
      );

      const bankDetails = await UserServices.getDriverBankDetails(profileId);

      setBankDetails(bankDetails);
      console.log("DRIVER DETAILS:", bankDetails);
    });

    FleetServices.fetchDriversVehicles(driverProfile?.user?.id).then(
      (response) => {
        setVehicle(response[0] || {});
      }
    );
  }, [profileId, driverProfile?.user?.id]);

  const handleApprove = () => {
    if (window.confirm("Are you sure you want to approve driver?")) {
      setLoading(true);
      UserServices.ApproveDriver(parseInt(driverProfile?.id)).then(() => {
        toast({
          ...toastProps,
          title: "Success!",
          description:
            user?.first_name + " " + user?.last_name + " Approved successfuly",
          status: "success",
        });
        setLoading(false);

        auth.getProfiles().then((response) => {
          setDriverProfile(
            response.find((user) => user.id === parseInt(profileId))
          );
        });
      });
    }
  };

  console.log(driverProfile);

  return (
    <>
      <Box p={"3"} maxH={"91%"} overflowY={"scroll"}>
        <BreadCrumb
          icon={<BiIdCard />}
          title={`Applications /`}
          subtitle={
            driverProfile?.user?.first_name +
            " " +
            driverProfile?.user?.last_name
          }
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
                <Image
                  h={"full"}
                  objectFit={"cover"}
                  src={
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png"
                  }
                />
              </Box>
              <Text
                fontSize={"xl"}
                textTransform={"uppercase"}
                fontWeight={"semibold"}
              >
                {profileId}
              </Text>

              <Text fontSize={"sm"} fontWeight={"light"}>
                {driverProfile?.user?.is_driver
                  ? "Driver"
                  : driverProfile?.user?.is_admin
                  ? "Admin"
                  : "User"}
                :{" "}
                {driverProfile?.user?.first_name +
                  " " +
                  driverProfile?.user?.last_name}
              </Text>
            </Wrapper>

            {/* Personal information*/}
            <Box>
              <Box className="flex justify-between py-2 px-5">
                <Text fontSize={"lg"} fontWeight={"medium"}>
                  Personal information
                </Text>

                <ActionButton>
                  <GrEdit
                    onClick={() => {
                      setCurrent({
                        id: driverProfile?.user?.id,
                        first_name: driverProfile?.user?.first_name,
                        last_name: driverProfile?.user?.last_name,
                        is_admin: driverProfile?.user?.is_admin,
                        is_driver: driverProfile?.user?.is_driver,
                        email: driverProfile?.user?.email,
                        phonenumber: driverProfile?.user?.phonenumber,
                      });
                      handleEditPersonalInfoOpenModal();
                    }}
                  />
                </ActionButton>
              </Box>
              <Wrapper
                my={"2"}
                p={"5"}
                borderRadius={"none"}
                className={"flex justify-center items-center gap-3"}
              >
                <Box className="text-right text-sm flex flex-col gap-4">
                  <Text fontWeight={"medium"}>Full name</Text>
                  <Text fontWeight={"medium"}>Category</Text>
                  {/* <Text fontWeight={"medium"}>Location</Text> */}
                  <Text fontWeight={"medium"}>Email</Text>
                  <Text fontWeight={"medium"}>Phone number</Text>
                  <Text fontWeight={"medium"}>Onboarding date</Text>
                  {/* <Text fontWeight={"medium"}>Last edit date</Text> */}
                </Box>

                <div className={"bg-zinc-200 h-48 w-0.5 rounded-full"} />

                <Box className="text-left text-sm flex flex-col gap-4">
                  <Text>
                    {driverProfile?.user?.first_name +
                      " " +
                      driverProfile?.user?.last_name}
                  </Text>
                  <Text>
                    {" "}
                    {driverProfile?.user?.is_driver
                      ? "Driver"
                      : driverProfile?.user?.is_admin
                      ? "Admin"
                      : "User"}
                    :{" "}
                    {driverProfile?.user?.first_name +
                      " " +
                      driverProfile?.user?.last_name}
                  </Text>
                  {/* <Text>Nairobi CBD, Nairobi</Text> */}
                  <Text>{driverProfile?.user?.email}</Text>
                  <Text>{driverProfile?.user?.phonenumber}</Text>
                  <Text>{driverProfile?.user?.date_joined}</Text>
                  {/* <Text>3/10/2022</Text> */}
                </Box>
              </Wrapper>
            </Box>
            {/* <GrEdit
                    onClick={() => {
                      setCurrent({
                        id: vehicle?.id,
                        reg_number: vehicle?.reg_number,
                        color: vehicle?.color,
                        vehicle_type: vehicle?.vehicle_type,
                        model: vehicle?.model,
                        owner: driverProfile?.user?.id,
                      });
                      handleEditVehicleInfoOpenModal();
                    }}
                  /> */}
            {/* vehicle information */}
            <Box>
              <Box className="flex justify-between py-2 px-5">
                <Text fontWeight={"medium"}>Vehicle information</Text>

                <ActionButton>
                  <GrEdit
                    onClick={() => {
                      setCurrent({
                        id: vehicle?.id,
                        reg_number: vehicle?.reg_number,
                        color: vehicle?.color,
                        vehicle_type: vehicle?.vehicle_type,
                        model: vehicle?.model,
                        owner: driverProfile?.user?.id,
                      });
                      handleEditVehicleInfoOpenModal();
                    }}
                  />
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
                  <Text>{vehicle?.reg_number}</Text>
                  <Text>{vehicle?.color || "__"}</Text>
                  <Text>{vehicle_types[vehicle?.vehicle_type]}</Text>
                  <Text>{vehicle?.model || "__"}</Text>
                  <Text>{vehicle?.owner?.date_joined || "__"}</Text>
                </Box>
              </Wrapper>
            </Box>
            <Box>
              <Box className="flex justify-between py-2 px-5">
                <Text fontWeight={"medium"}>Bank information</Text>
              </Box>
              <Wrapper
                my={"2"}
                p={"5"}
                borderRadius={"none"}
                className={"flex justify-center items-center gap-3 text-sm"}
              >
                <Box className="text-right flex flex-col gap-4">
                  <Text fontWeight={"medium"}>Acc Name</Text>
                  <Text fontWeight={"medium"}>Acc Number</Text>
                  <Text fontWeight={"medium"}>Bank Branch</Text>
                  <Text fontWeight={"medium"}>Bank Name</Text>
                </Box>

                <div className={"bg-zinc-200 h-40 w-0.5 rounded-full"} />

                <Box className="text-left flex flex-col gap-4">
                  <Text>{bankDetails?.account_name || "__"}</Text>
                  <Text>{bankDetails?.account_number || "__"}</Text>
                  <Text>{bankDetails?.bank_branch || "__"}</Text>
                  <Text>{bankDetails?.bank_name || "__"}</Text>
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
                  <Image
                    src={driverProfile?.driving_license}
                    alt={"license"}
                    h={"150px"}
                  />
                </Box>

                <hr className="my-2" />

                <Text fontSize={"lg"} fontWeight={"semibold"}>
                  Insurance Document
                </Text>

                <Box p={"2"}>
                  <Image
                    src={driverProfile?.insurance}
                    alt={"insurance"}
                    h={"540px"}
                  />
                </Box>
              </Box>

              <Box className="flex gap-4 justify-end">
                {!driverProfile?.is_approved && (
                  <>
                    <button
                      onClick={handleRejectOpenModal}
                      className="text-primary_yellow border-[1.5px] border-primary_yellow rounded-md items-center flex gap-2 px-16 py-3"
                    >
                      <Text fontWeight={"semibold"}>Reject</Text>
                    </button>

                    {!loading ? (
                      <button
                        onClick={handleApprove}
                        className="bg-primary_yellow rounded-md items-center flex gap-2 px-16 py-3"
                      >
                        <Text fontWeight={"semibold"}>Approve</Text>
                      </button>
                    ) : (
                      <LoadingButton
                        borderRadius={"md"}
                        fontSize={"14px"}
                        px={16}
                        h={"50px"}
                      />
                    )}
                  </>
                )}
              </Box>
            </Wrapper>
          </Box>
        </Box>
      </Box>

      <EditPersonalInfoModal
        openModal={openPersonalInfoModal}
        handleCloseModal={handleEditPersonalInfoCloseModal}
        current={current}
      />

      <EditVehicleModal
        openModal={openVehicleInfoModal}
        handleCloseModal={handleEditVehicleInfoCloseModal}
        current={current}
      />

      <RejectModal
        handleCloseModal={handleRejectCloseModal}
        openModal={openRejectModal}
      />
    </>
  );
};

export default ViewDriver;

const vehicle_types = ["Motorbike", "Vehicle", "Van", "Truck"];
