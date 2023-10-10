import { HStack } from "@chakra-ui/react";
import React, { useMemo } from "react";
import { Cancelled, Completed, Picked, Requests } from "../../assets/svg";
// import Example from "../charts/Pie";
import Wrapper from "../general/Wrapper";
import ActivityItem from "./ActivityItem";

const ActivitiesCard = ({ percentageCompleted, bookingActivities }) => {
  //   const handleChart = useCallback(() => {}, []);
  // const handleChart = React.useMemo(() => );
  // const percentageNotCompleted = 100 - percentageCompleted;

  const activities = useMemo(
    () => [
      {
        title: "Requests",
        no: bookingActivities[0],
        icon: <Requests />,
        bg: "current_bg",
      },
      {
        title: "Picked",
        no: bookingActivities[1],
        icon: <Picked />,
        bg: "picked_bg",
      },
      {
        title: "Completed",
        no: bookingActivities[2],
        icon: <Completed />,
        bg: "completed_bg",
      },
      {
        title: "Cancelled",
        no: bookingActivities[3],
        icon: <Cancelled />,
        bg: "cancelled_bg",
      },
    ],
    [bookingActivities]
  );

  return (
    <Wrapper py={"2"}>
      <HStack gap={"3"} justifyContent={"space-between"}>
        <div className="flex flex-wrap 2xl:flex-nowrap gap-4">
          {activities?.map((act) => (
            <ActivityItem
              icon={act?.icon}
              name={act?.title}
              number={act.no}
              bg={act?.bg}
            />
          ))}
        </div>

        {/* <div className="lg:flex hidden items-center gap-1"> */}
        {/* <Example /> */}
        {/* <div className="h-100px w-100px"> */}
        {/* <div className="h-[80px] w-[80px] ml-8"> */}
        {/* <Doughnat options={chartOptions} data={chartData} /> */}
        {/* </div> */}
        {/*
          <div className="text-center">
            <Text
              textAlign={"center"}
              color={"primary_green"}
              fontWeight={"semibold"}
              fontSize={"xl"}
            >
              {percentageCompleted}/100
            </Text>
            <Text
              fontSize={"sm"}
              fontWeight={"light"}
              className={"text-zinc-400"}
            >
              Completed Bookings
            </Text>
          </div>
          {/* </div> */}
        {/* </div>  */}
      </HStack>
    </Wrapper>
  );
};

export default ActivitiesCard;
