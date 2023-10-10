import { Box, HStack, Text } from "@chakra-ui/react";
import React, { useMemo, useState, useEffect } from "react";
import { Doughnat } from "../components/charts/Doughnat";
import ActivitiesCard from "../components/dashboard/ActivitiesCard";
import Breadcrumb from "../components/dashboard/Breadcrumb";
import Table from "../components/general/Table";
import Wrapper from "../components/general/Wrapper";
import BookingService from "../utils/services/BookingServices";

const Dashboard = () => {
  // Bar chart data
  const [bookings, setBookings] = useState([]);
  const [barChartMonths, setBarChartMonths] = useState([]);
  const [createdBooking, setCreatedBooking] = useState("");
  const [completedBooking, setCompletedBooking] = useState("");

  // Activities
  const [requests, setRequests] = useState("");
  const [picked, setPicked] = useState("");
  const [completed, setCompleted] = useState("");
  const [canceled, setCanceled] = useState("");

  // Doughnat chart data total bookings
  const [totalBookingPercentage, setTotalBookingPercentage] = useState("");

  // Doughnat chart data vehicle type fliters
  const [vehicleTypeCount, setVehicleTypeCount] = useState("");
  const [vehiclesTypes, setVehiclesType] = useState("");
  const [createdBookingPerVehicleType, setCreatedBookingPerVehicleType] =
    useState("");
  const [completedBookingPerVehicleType, setCompletedBookingPerVehicleType] =
    useState("");

  // Array of Months
  const MONTHS = useMemo(
    () => [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ],
    []
  );

  const VECHILE_TYPES = useMemo(
    () => ["Motorbike", "Vehicle", "Van", "Truck"],
    []
  );

  useEffect(() => {
    BookingService.fetchBookings().then(async (response) => {
      setBookings(response);
      console.log("bookings", response);

      // setLoading(false);
    });
  }, []);

  useEffect(() => {
    // Setting up activities data
    setRequests(
      bookings.reduce((acc, obj) => (obj.status >= "0" ? (acc += 1) : acc), 0)
    );
    setPicked(
      bookings.reduce((acc, obj) => (obj.status === "3" ? (acc += 1) : acc), 0)
    );
    setCompleted(
      bookings.reduce((acc, obj) => (obj.status === "5" ? (acc += 1) : acc), 0)
    );
    setCanceled(
      bookings.reduce((acc, obj) => (obj.status === "0" ? (acc += 1) : acc), 0)
    );

    // Bar chart and Doughnat chart data
    if (bookings.length > 0) {
      const months = Object.entries(
        bookings.reduce((b, a) => {
          let month = a.created_at.split("T")[0].substr(0, 10);
          console.log("months", month);
          if (b.hasOwnProperty(month)) b[month].push(a);
          else b[month] = [a];
          return b;
        }, {})
      )
        .sort((a, b) => a[0].localeCompare(b[0]))
        .map((e) => ({ [e[0]]: e[1] }));

      let monthsArray = [];
      let monthlyCreatedTotals = [];
      let monthlyCompletedTotals = [];
      let percentageCompleted = "";

      months.forEach((item) => {
        const key = Object.keys(item)[0];
        const monthOfDate = MONTHS[new Date(key).getMonth()];
        monthsArray.push(monthOfDate);

        const arrayOfBookings = Object.values(item)[0];

        const totalCreatedBookingsMonthly = arrayOfBookings?.reduce(
          (acc, obj) => (obj.status >= 0 ? (acc += 1) : acc),
          0
        );
        monthlyCreatedTotals.push(totalCreatedBookingsMonthly);

        const totalCompletedBookingsMonthly = arrayOfBookings?.reduce(
          (acc, obj) => (obj.status === 5 ? (acc += 1) : acc),
          0
        );
        monthlyCompletedTotals.push(totalCompletedBookingsMonthly);

        // Sum created booking
        const totalCreatedBookings = monthlyCreatedTotals?.reduce(
          (acc, obj) => (acc += obj),
          0
        );

        //Sum up completed booking
        const totalCompletedBookings = monthlyCompletedTotals?.reduce(
          (acc, obj) => (acc += obj),
          0
        );

        //Calculate completed percentage
        percentageCompleted = Math.round(
          (totalCompletedBookings / totalCreatedBookings) * 100
        );
      });
      setBarChartMonths(monthsArray);
      setCreatedBooking(monthlyCreatedTotals);
      setCompletedBooking(monthlyCompletedTotals);
      setTotalBookingPercentage(percentageCompleted);

      //Vehicle type vehicle type count
      const vehicles = Object.entries(
        bookings.reduce((b, a) => {
          let vehicle = a.booking.vehicle_type;
          if (b.hasOwnProperty(vehicle)) b[vehicle].push(a);
          else b[vehicle] = [a];
          return b;
        }, {})
      )
        .sort((a, b) => a[0].localeCompare(b[0]))
        .map((e) => ({ [e[0]]: e[1] }));

      let vehicleArray = [];
      let vehicleCount = [];
      let totalBookingCreatedPerVehicleType = [];
      let totalBookingCompletedPerVehicleType = [];

      vehicles.forEach((item) => {
        const key = Object.keys(item)[0];
        const vehicle = VECHILE_TYPES[key];
        vehicleArray.push(vehicle);

        const arrayOfVehicle = Object.values(item)[0];

        const totalCountOfVehiclePerType = arrayOfVehicle.reduce(
          (acc, obj) => (acc += 1),
          0
        );
        vehicleCount.push(totalCountOfVehiclePerType);

        const totalCreatedBookingPerVehicleType = arrayOfVehicle.reduce(
          (acc, obj) => (obj.status >= 0 ? (acc += 1) : acc),
          0
        );
        totalBookingCreatedPerVehicleType.push(
          totalCreatedBookingPerVehicleType
        );

        const totalCompletedBookingPerVehicleType = arrayOfVehicle.reduce(
          (acc, obj) => (obj.status === 5 ? (acc += 1) : acc),
          0
        );
        totalBookingCompletedPerVehicleType.push(
          totalCompletedBookingPerVehicleType
        );
      });
      setVehiclesType(vehicleArray);
      setVehicleTypeCount(vehicleCount);
      setCreatedBookingPerVehicleType(totalBookingCreatedPerVehicleType);
      setCompletedBookingPerVehicleType(totalBookingCompletedPerVehicleType);
    }
  }, [MONTHS, VECHILE_TYPES, bookings]);

  const bookingActivities = useMemo(
    () => [requests, picked, completed, canceled],
    [requests, picked, completed, canceled]
  );

  const bookingsByProduct = useMemo(
    () => ({
      options: {
        plugins: {
          centerText: {
            display: true,
            text: "90%",
          },
          legend: {
            display: true,
            position: "right",
          },
        },
      },

      data: {
        labels: vehiclesTypes,
        datasets: [
          {
            label: "# of Votes",
            data: vehicleTypeCount,
            backgroundColor: [
              "#6EF07B",
              "#6FCDFB",
              "#FF65C1",
              "#BB1600",
              "#FFCF63",
            ],
          },
        ],
        text: "40",
      },
    }),
    [vehicleTypeCount, vehiclesTypes]
  );

  // const barChartBookingsByVehicleType = useMemo(
  //   () => ({
  //     options: {
  //       // responsive: true,
  //       maintainAspectRatio: false,
  //       plugins: {
  //         legend: {
  //           position: "bottom",
  //         },
  //         // title: {
  //         //   display: true,
  //         //   text: "Chart.js Bar Chart",
  //         // },
  //       },
  //     },

  //     data: {
  //       labels: vehiclesTypes,
  //       datasets: [
  //         {
  //           label: "Created booking",
  //           data: createdBookingPerVehicleType,
  //           backgroundColor: "#EFAF1D",
  //         },
  //         {
  //           label: "Complete booking",
  //           data: completedBookingPerVehicleType,
  //           backgroundColor: "#00A406",
  //         },
  //       ],
  //     },
  //   }),

  //   [
  //     vehiclesTypes,
  //     createdBookingPerVehicleType,
  //     completedBookingPerVehicleType,
  //   ]
  // );

  const barChartBookingOverview = useMemo(
    () => ({
      options: {
        // responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: "bottom",
          },
        },
      },

      data: {
        labels: barChartMonths,
        datasets: [
          {
            label: "Created booking",
            data: createdBooking,
            backgroundColor: "#EFAF1D",
          },
          {
            label: "Complete booking",
            data: completedBooking,
            backgroundColor: "#00A406",
          },
        ],
      },
    }),

    [barChartMonths, createdBooking, completedBooking]
  );

  // const radialKeys = [
  //   { text: "very satisified", color: "#16AC52" },
  //   { text: "satisified", color: "#EAC625" },
  //   { text: "dissatisfied", color: "#D9D9D9" },
  //   { text: "very dissatisfied", color: "#BB1600" },
  // ];

  return (
    <Box p={"3"} className="max-h-[calc(100%-80px)]" overflowY={"scroll"}>
      <Breadcrumb />

      <ActivitiesCard
        percentageCompleted={totalBookingPercentage}
        bookingActivities={bookingActivities}
      />

      {/* ranking and revenue breakdown */}
      <HStack my={"4"} gap={"3"}>
        <Wrapper className={"w-1/2"} h={"350px"}>
          {/* header */}
          <HStack justifyContent={"space-between"} mb={"2"}>
            <Text fontWeight={"semibold"}>General Booking Info</Text>
          </HStack>

          {/* body */}
          <Table size={"sm"} headers={[...bookingHeaders]}>
            {bookings?.map((data, key) => {
              const isEven = key % 2;

              return (
                <tr
                  className={`h-10 capitalize text-[12px] ${
                    isEven ? "bg-[#F9F9F9]" : "white"
                  }`}
                >
                  <td className="  py-1 px-4">{data?.booking.booking_id}</td>
                  <td className="  py-1 px-4">{data?.amount}</td>
                  <td className=" py-1 px-4">
                    {data?.booking.formated_address}
                  </td>
                  <td className=" py-1 px-4">{data?.booking.date_created}</td>
                  <td className=" py-1 px-4">{data?.booking.scheduled_date}</td>
                </tr>
              );
            })}
          </Table>
        </Wrapper>

        <Wrapper className={"w-1/2 flex flex-col "} h={"350px"}>
          {/* header */}
          <HStack justifyContent={"space-between"} px={"5"}>
            <Text fontWeight={"semibold"}>Bookings by vehicle type</Text>
          </HStack>

          {/* body */}
          <div className=" h-[350px] flex justify-start mx-auto">
            <Doughnat
              data={bookingsByProduct.data}
              options={bookingsByProduct.options}
            />
          </div>
        </Wrapper>
      </HStack>
    </Box>
  );
};

const bookingHeaders = [
  "Booking ID",
  "Amount",
  "Booking Active",
  "Date Created",
  "Scheduled Date",
];

export default Dashboard;
