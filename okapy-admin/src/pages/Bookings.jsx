import { Box, Button, HStack } from "@chakra-ui/react";
import React, { useEffect } from "react";
import { Transaction } from "../assets/svg";
import BreadCrumb from "../components/general/BreadCrumb";
import { ConfigProvider, Table } from "antd";
import _ from "lodash";
import Wrapper from "../components/general/Wrapper";
import BookingServices from "../utils/services/BookingServices";
import { FiEye } from "react-icons/fi";
import { IoSearchOutline } from "react-icons/io5";
import { RiDeleteBin5Line } from "react-icons/ri";
import ViewModal from "../components/Booking/ViewModal";
import CInput from "../components/general/Input";
import { STATUS_LIST } from "../utils/Helper";


const Bookings = () => {
  // const toast = useToast();
  const [openModal, setOpenModal] = React.useState(false);
  const [bookingId, setBookingId] = React.useState();
  const [bookings, setBookings] = React.useState([]);
  const [searchValue, setSearchValue] = React.useState("");
  const [filterBookings, setFilterBookings] = React.useState("");
  const [current, setCurrent] = React.useState({});
  const [stateLoading, setStateLoading] = React.useState(true);


  const handleOpenModal = React.useCallback((id) => {
    setOpenModal(true);
    setBookingId(id);
  }, []);

  const handleCloseModal = React.useCallback(() => {
    setOpenModal(false);
  }, []);

  useEffect(() => {
    BookingServices.fetchBookings().then((response) => {
      let arr = [];
      console.log(response)
      response.forEach(async (element) => {
        await BookingServices.getBookingReceiver(element?.booking?.id).then((res) => {
          const bookingObj = {
            pickup: element?.booking?.formated_address || "",
            destination: res?.formated_address || "",
            sender: element?.owner?.first_name + " " + element?.owner?.last_name || "",
            senderPhoneNumber: element?.owner?.phonenumber || "",
            receiver: res?.name || "",
            receiverPhoneNumber: res?.phonenumber || "",
            driver: element?.driver?.first_name + " " + element?.driver?.last_name || "",
            driverPhoneNumber: element?.driver?.phonenumber || "",
            status: element?.status,
            id: element?.id,
          };
          arr.push(bookingObj);
        })
        setBookings(arr);
        setFilterBookings(arr);
        setTimeout(() => setStateLoading(false), 800);

      })
    });
  }, []);

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
    else return bookings;
  };

  useEffect(() => {
    setFilterBookings(handleSearch(bookings, searchValue));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [bookings, searchValue]);



  const columns = [
    {
      title: "Pickup",
      dataIndex: "pickup",
      sorter: (a, b) => a?.pickup.localeCompare(b?.pickup),
    },
    {
      title: "Destination",
      dataIndex: "destination",
      sorter: (a, b) => a?.destination.localeCompare(b?.destination),
    },
    {
      title: "Sender",
      dataIndex: "sender",
      sorter: (a, b) => a?.sender.localeCompare(b?.sender),
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
              <FiEye onClick={() => {
                setCurrent(n);
                handleOpenModal(n?.id);
              }}
              />
            </ActionButton>

            <ActionButton>
              <RiDeleteBin5Line />
            </ActionButton>
          </Box>
        );
      },
    },
  ]

  return (
    <>
      <Box p={"3"} maxH={"91%"} overflowY={"scroll"} position={"relative"}>
        <BreadCrumb icon={<Transaction />} title={"Bookings"} />
        {/* <Loader /> */}

        <Wrapper my={"2"} p={"3"}>
          <HStack
            gap={"2"}
            className={"border-b-2 border-zinc-200"}
            h={"12"}
            mx={"2"}
          >
            <SubNavItem isCurrent title={"Ongoing"} handleClick={() => { }} />
            {/* <SubNavItem title={"Scheduled"} handleClick={() => {}} />
            <SubNavItem title={"Completed"} handleClick={() => {}} /> */}
          </HStack>

          {/* search and table actions */}
          <HStack py={"4"} justifyContent={"space-between"}>
            {/* /search input */}
            <CInput
              icon={<IoSearchOutline className="text-xl" />}
              handleChange={(e) => {
                setSearchValue(e?.target?.value);
              }}
            />
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
                loading={stateLoading}
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
                dataSource={filterBookings}
              />
            </Box>
          </ConfigProvider>
        </Wrapper>
      </Box>
      <ViewModal
        bookingId={bookingId}
        openModal={openModal}
        handleCloseModal={handleCloseModal}
        current={current}
      />
    </>
  );
};

export default Bookings;

const SubNavItem = ({ title, isCurrent }) => (
  // <Button>

  // </Button>
  <Button
    h={"12"}
    cursor={"pointer"}
    borderRadius={"none"}
    bg={"white "}
    className={`text-primary_yellow text-xl ${isCurrent ? "text-dark_green " : "text-zinc-400 "
      }`}
    //  onClick={handleLogout}
    _hover={{
      bg: "white",
      borderBottomColor: "dark_green",
      textColor: "dark_green",
    }}
    _focus={{ bg: "white" }}
    fontWeight={isCurrent ? "semibold" : "normal"}
    // py={"3"}
    borderBottomWidth={"2px"}
    borderBottomColor={isCurrent ? "dark_green" : "none"}
  >
    {title}
  </Button>
);

// const tableData = [
//   {
//     pickup: "Saljona apartment",
//     destination: "Brooke Manor",
//     sender: "Collins joe",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 4,
//   },
//   {
//     pickup: "Saljona apartment",
//     destination: "Brooke Manor",
//     sender: "Collins joe",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 5,
//   },
//   {
//     pickup: "Saljona apartment",
//     destination: "Brooke Manor",
//     sender: "Collins joe",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 0,
//   },
//   {
//     pickup: "Saljona apartment",
//     destination: "Brooke Manor",
//     sender: "Collins joe",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 1,
//   },
//   {
//     pickup: "Saljona apartment",
//     destination: "Brooke Manor",
//     sender: "Collins joe",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 2,
//   },
//   {
//     pickup: "Saljona apartment",
//     destination: "Brooke Manor",
//     sender: "Collins joe",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 3,
//   },
//   {
//     pickup: "Saljona apartment",
//     destination: "Brooke Manor",
//     sender: "Collins joe",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 4,
//   },
//   {
//     pickup: "Saljona apartment",
//     destination: "Brooke Manor",
//     sender: "Collins joe",
//     receiver: "Ben Doe",
//     driver: "ken Driver",
//     status: 5,
//   },
// ];

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

