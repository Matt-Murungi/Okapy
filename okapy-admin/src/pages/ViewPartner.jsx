import { Box, Button, HStack, Image, Text } from "@chakra-ui/react";
import React, { useState, useCallback } from "react";
import { Transaction } from "../assets/svg";
import BreadCrumb from "../components/general/BreadCrumb";
import { ConfigProvider, Table } from "antd";
import Wrapper from "../components/general/Wrapper";

import _ from "lodash";

import { FiEye } from "react-icons/fi";
import { GrEdit } from "react-icons/gr";
import { IoSearchOutline } from "react-icons/io5";
import { useNavigate, useParams } from "react-router-dom";
import BusinessImage from "../assets/images/business_image.png";
import CInput from "../components/general/Input";
import PrimaryButton from "../components/general/PrimaryButton";
import PartnerServices from "../utils/services/PartnerServices";
import BookingServices from "../utils/services/BookingServices";
import { partnerCategories } from "./Partners";
import EditPartnerModal from "../components/partner/EditPartnerModal";

const ViewPartner = () => {
  const navigate = useNavigate();
  const params = useParams();

  const [partner, setPartner] = useState({});
  const [openModal, setOpenModal] = useState(false);
  const [current, setCurrent] = useState({});
  const [userBookings, setUserBookings] = useState([]);
  const [filterUserBookings, setFilterUserBookings] = useState([]);
  const [searchValue, setSearchValue] = useState("");
  const [loading, setLoading] = useState(true)

  const handleViewUser = (user) => {
    navigate(`/users/${user}`, user);
  };

  const handleOpenModal = useCallback(() => {
    setOpenModal(true);
  }, []);

  const handleCloseModal = useCallback(() => {
    setOpenModal(false);
  }, []);

  React.useEffect(() => {
    PartnerServices.fetchSinglePartner(params.id).then((response) => {
      setPartner(response);
      BookingServices.ownersBookings(response?.owner?.id).then((response) => {
        let arr = [];
        response.forEach(async (element) => {
          const receiver = await BookingServices.getBookingReceiver(element?.booking?.id);
          const bookingObj = {
            pickup: element?.booking?.formated_address || "",
            destination: receiver?.formated_address || "",
            sender: element?.owner?.first_name + " " + element?.owner?.last_name || "",
            senderPhoneNumber: element?.owner?.phonenumber || "",
            receiver: receiver?.name || "",
            receiverPhoneNumber: receiver?.phonenumber || "",
            driver: element?.driver?.first_name + " " + element?.driver?.last_name || "",
            driverPhoneNumber: element?.driver?.phonenumber || "",
            status: element?.status,
            id: element?.id,
          };
          arr.push(bookingObj);
        })
        setUserBookings(arr);
        setFilterUserBookings(arr);
        setTimeout(() => setLoading(false), 1000);
      });
    });
  }, [params]);
  // const

  const handleSearch = (arr, cond) => {
    const newArr = _.filter(arr, (obj) => {
      if (cond) {
        return (
          obj?.pickup?.toLowerCase()?.includes(cond?.toLowerCase()) ||
          obj?.destination?.toLowerCase()?.includes(cond?.toLowerCase()) ||
          obj?.sender?.toLowerCase()?.includes(cond?.toLowerCase()) ||
          obj?.receiver?.toLowerCase()?.includes(cond?.toLowerCase()) ||
          obj?.driver?.toLowerCase()?.includes(cond?.toLowerCase())
        );
      }
    });

    if (cond) return newArr;
    else return userBookings;
  };

  React.useEffect(() => {
    setFilterUserBookings(handleSearch(userBookings, searchValue));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [userBookings, searchValue]);

  const columns = [
    {
      title: "Destination",
      dataIndex: "destination",
      sorter: (a, b) => a?.destination.localeCompare(b?.destination),
    },
    {
      title: "Receiver",
      dataIndex: "receiver",
      sorter: (a, b) => a?.receiver.localeCompare(b?.receiver),
    },
    {
      title: "Driver",
      dataIndex: "driver",
      sorter: (a, b) => a?.driver.localeCompare(b?.driver),
    },
    {
      title: "Status",
      dataIndex: "status",
      render: (text) => {
        const bg =
          text === 0
            ? "bg-primary_red"
            : text === 5
              ? "bg-primary_green"
              : "bg-primary_yellow_light";

        return (
          <Box display={"flex"}>
            <Box
              py={"1"}
              px={"2"}
              fontSize={"xs"}
              textTransform={"capitalize"}
              className={`${bg} rounded-md font-medium text-center text-white`}
            >
              {STATUS_LIST[text]}
            </Box>
          </Box>
        );
      }
    },
    {
      title: "Action",
      dataIndex: "action",
      render: (_, n) => {
        return (
          <Box className="flex gap-6 justify-start">
            <ActionButton >
              <FiEye onClick={() => handleViewUser(n?.id)}
              />
            </ActionButton>
          </Box>
        );
      },
    },
  ]

  return (
    <>
      <Box p={"3"} maxH={"91%"} overflowY={"scroll"}>
        <BreadCrumb
          icon={<Transaction />}
          title={`Partners /`}
          subtitle={partner?.owner?.first_name + " " + partner?.owner?.last_name}
        />
        <Box className="flex gap-3 ">
          <Box className="w-2/5">
            <Wrapper
              my={"4"}
              p={"8"}
              borderRadius={"none"}
              className={"flex flex-col rounded"}
            >
              {/* body */}

              <Image
                w={"full"}
                objectFit={"cover"}
                src={BusinessImage}
                mb={"4"}
              />

              <Text
                fontSize={"xl"}
                textTransform={"uppercase"}
                fontWeight={"semibold"}
              >
                {partner?.owner?.first_name + " " + partner?.owner?.last_name}
              </Text>

              <Text fontSize={"sm"} fontWeight={"normal"}>
                {partnerCategories[partner?.sector]}
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
                        id: partner?.owner?.id,
                        first_name: partner?.owner?.first_name,
                        last_name: partner?.owner?.last_name,
                        is_admin: partner?.owner?.is_admin,
                        is_driver: partner?.owner?.is_driver,
                        email: partner?.owner?.email,
                        phonenumber: partner?.owner?.phonenumber,
                      })
                      handleOpenModal()
                    }}
                  />
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
                  {/* <Text fontWeight={"medium"}>Last edit date</Text> */}
                </Box>

                <div className={"bg-zinc-200 h-60 w-0.5 rounded-full"} />

                <Box className="text-left flex flex-col gap-4">
                  <Text>
                    {partner?.owner?.first_name + " " + partner?.owner?.last_name}
                  </Text>
                  <Text>
                    {partner?.owner?.is_driver
                      ? "Driver"
                      : partner?.owner?.is_admin
                        ? "Admin"
                        : "User"}
                  </Text>
                  <Text>Nairobi CBD, Nairobi</Text>
                  <Text> {partner?.owner?.email}</Text>
                  <Text> {partner?.owner?.phonenumber}</Text>
                  <Text> {partner?.owner?.date_joined}</Text>
                </Box>
              </Wrapper>
            </Box>

            {/* vehicle information */}
            {/* <Box>
            <Box className="flex justify-between py-2 px-5">
              <Text fontSize={"lg"} fontWeight={"medium"}>
                Payment Details
              </Text>

              <ActionButton>
                <GrEdit />
              </ActionButton>
            </Box>
            <Wrapper my={"2"} borderRadius={"none"} className={"gap-3"}> */}
            {/* mini cards */}
            {/* <HStack w={"full"} fontFamily={"Poppins"}>
                <MiniCard no={"24"} text={"Total Bookings"} icon={<Lorry />} />
                <MiniCard
                  no={"3"}
                  text={"Canceled Bookings"}
                  icon={<Lorry />}
                />
                <MiniCard
                  no={"KES. 140,000"}
                  text={"Customer Value"}
                  icon={<GoGraph />}
                />
              </HStack>

              <Box mt={"3"}>
                <Table headers={[...Object.keys(sample_payment_data[0])]}>
                  {sample_payment_data?.map((data, key) => {
                    const isEven = key % 2;

                    return (
                      <tr
                        className={`h-14 capitalize ${
                          isEven ? "bg-[#F9F9F9]" : "white"
                        }`}
                      >
                        <td className=" text-center py-3 px-4">{data?.date}</td>
                        <td className=" text-center py-3 px-4">
                          {data?.["method of payment"]}
                        </td>
                        <td className="text-center py-3 px-4">
                          {data?.amount}
                        </td>
                      </tr>
                    );
                  })}
                </Table>
              // </Box>
            </Wrapper> */}
            {/* </Box> */}
          </Box>

          {/* table */}
          <Wrapper my={"4"} p={"5 "} className={"w-3/5"}>
            <Text fontWeight={"semibold"} fontSize={"lg"}>
              Bookings
            </Text>

            {/* search and table actions */}
            <HStack py={"7"} justifyContent={"space-between"}>
              {/* /search input */}
              <CInput
                icon={<IoSearchOutline className="text-xl" />}
                handleChange={(e) => {
                  setSearchValue(e?.target?.value);
                }}
              />
              {/* actions */}
              <HStack gap={"2"}>
                <PrimaryButton className={"font-medium"}>
                  Reconcile payments
                </PrimaryButton>
              </HStack>
            </HStack>

            {/* body */}
            <ConfigProvider
            theme={{
              token: {
                colorPrimary: "#EFAF1C",
                colorPrimaryTextActive: "#19411D",
                colorPrimaryText: "#19411D",
                // colorBgBase: "#19411D",
                colorPrimaryBg: "#EFAF1C",
              },
            }}
          >
            <Box>
              <Table
                rowKey={(data) => data.id}
                loading={loading}
                pagination={{
                  defaultPageSize: 15,
                  showSizeChanger: true,
                  pageSizeOptions: ["10", "15", "20", "30"],
                }}
                // rowSelection={{
                //   type: "checkbox",
                //   ...rowSelection,
                // }}
                columns={columns}
                dataSource={filterUserBookings}
              />
            </Box>
          </ConfigProvider>
          </Wrapper>
        </Box>
      </Box>

      <EditPartnerModal
        openModal={openModal}
        handleCloseModal={handleCloseModal}
        current={current}
      />
    </>

  );
};

export default ViewPartner;

// const tableData = [
//   {
//     destination: "Brooke Manor",
//     sender: "ken Driver",
//     receiver: "Ben Doe",
//     status: 4,
//   },
//   {
//     destination: "Brooke Manor",
//     sender: "ken Driver",
//     receiver: "Ben Doe",
//     status: 5,
//   },
//   {
//     destination: "Brooke Manor",
//     sender: "ken Driver",
//     receiver: "Ben Doe",
//     status: 0,
//   },
//   {
//     destination: "Brooke Manor",
//     sender: "ken Driver",
//     receiver: "Ben Doe",
//     status: 1,
//   },
//   {
//     destination: "Brooke Manor",
//     sender: "ken Driver",
//     receiver: "Ben Doe",
//     status: 2,
//   },
//   {
//     destination: "Brooke Manor",
//     sender: "ken Driver",
//     receiver: "Ben Doe",
//     status: 3,
//   },
//   {
//     destination: "Brooke Manor",
//     sender: "ken Driver",
//     receiver: "Ben Doe",
//     status: 4,
//   },
//   {
//     destination: "Brooke Manor",
//     sender: "ken Driver",
//     receiver: "Ben Doe",
//     status: 5,
//   },
// ];
const STATUS_LIST = {
  1: "arrived at pickup",
  2: "picked up",
  3: "on trip",
  4: "arrived destination",
  0: "cancelled",
  5: "completed",
};
const ActionButton = ({ bg, children, handleClick }) => (
  <Button
    fontSize={"lg"}
    p={"0"}
    h={"30px"}
    className={`${bg} rounded-md  text-dark_green border border-dark_green`}
    onClick={handleClick}
  >
    {children}
  </Button>
);

// const MiniCard = ({ text, no, icon }) => (
//   <Box borderRadius={"xl"} h={"20"} p={"2"} flexGrow={"1"}>
//     <Text fontSize={"sm"} className={"text-zinc-400"}>
//       {text}
//     </Text>
//     <Box className="flex justify-between items-center">
//       <Text fontWeight={"bold"} fontSize={"lg"}>
//         {no}
//       </Text>

//       <Center
//         h={"40px"}
//         w={"40px"}
//         p={"1.5"}
//         bg={"current_bg"}
//         borderRadius={"md"}
//       >
//         {icon}
//       </Center>
//     </Box>
//   </Box>
// );

// const sample_payment_data = [
//   {
//     date: "5/3/2019",
//     "method of payment": "Mpesa",
//     amount: "350",
//   },
//   {
//     date: "5/3/2019",
//     "method of payment": "Mpesa",
//     amount: "350",
//   },
//   {
//     date: "5/3/2019",
//     "method of payment": "Mpesa",
//     amount: "350",
//   },
// ];
