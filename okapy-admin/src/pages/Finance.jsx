import { Box, Button, HStack } from "@chakra-ui/react";
import React, { useState, useEffect, useMemo } from "react";
import BreadCrumb from "../components/general/BreadCrumb";
import Wrapper from "../components/general/Wrapper";
import EarningServices from "../utils/services/EarningServices";
import { GoGraph } from "react-icons/go";
import FinanceCard from "../components/finance/FinanceCard";
import Paid from "../components/finance/sub_screens/Paid";

const Finance = () => {
  const [currentSubNav, setCurrent] = useState("paid"); //processing,paid
  const [paidInvoices, setPaidInvoices] = useState([]);
  // const [unPaidInvoices, setUnPaidInvoices] = useState([]);
  const [paidInvoicesCount, setPaidInvoicesCount] = useState([]);
  const [unPaidInvoicesCount, setUnPaidInvoicesCount] = useState([]);
  const [stateLoading, setStateLoading] = useState(true);

  // const fetchUnpaid = () => {
  //   // Unpaid invoices
  //   EarningServices.fetchRequestEarnings().then((response) => {
  //     setUnPaidInvoices(response);
  //     setUnPaidInvoicesCount(
  //       response.reduce((acc, obj) => (acc += parseInt(obj.amount)), 0)
  //     );
  //     setStateLoading(false);
  //   });
  // };

  useEffect(() => {
    // Paid invoices
    EarningServices.fetchEarnings().then((response) => {
      setPaidInvoices(response.filter((data) => data.status === "5"));
      console.log(response);
      setPaidInvoicesCount(
        response.reduce(
          (acc, obj) =>
            obj.status === "5" ? (acc += parseInt(obj.amount)) : acc,
          0
        )
      );
      setUnPaidInvoicesCount(
        response.reduce(
          (acc, obj) =>
            obj.status !== "5" ? (acc += parseInt(obj.amount)) : acc,
          0
        )
      );
      setStateLoading(false);
    });

    // fetchUnpaid();
  }, []);

  const cards_data = useMemo(
    () => [
      {
        text: "Paid",
        number: paidInvoicesCount,
      },
      {
        text: "Unpaid",
        number: unPaidInvoicesCount,
      },
      // {
      //   text: "Withdrawal Requests",
      //   number: 75000,
      // },
      // {
      //   text: "Failed Transactions",
      //   number: 6,
      // },
    ],
    [
      paidInvoicesCount,
      // unPaidInvoicesCount
    ]
  );

  return (
    <Box p={"3"} maxH={"91%"} overflowY={"scroll"}>
      <BreadCrumb icon={<GoGraph />} title={"Finance"} />

      <HStack pt={"3"} gap={2}>
        {cards_data?.map((item) => (
          <FinanceCard no={item?.number} text={item?.text} />
        ))}
      </HStack>

      <Box className="flex gap-1 " letterSpacing={"wide"}>
        <Wrapper w={"100%"} my={"3"} p={"3"}>
          <HStack
            gap={"2"}
            className={"border-b-2 border-zinc-200"}
            h={"10"}
            mx={"4"}
          >
            <SubNavItem
              isCurrent={currentSubNav.toLowerCase() === "paid"}
              handleClick={() => setCurrent("paid")}
              title={"Paid invoices"}
            />
            {/* <SubNavItem
              isCurrent={currentSubNav.toLowerCase() === "unpaid"}
              handleClick={() => setCurrent("unpaid")}
              title={"unpaid invoices"}
            /> */}
          </HStack>

          {/* {currentSubNav === "paid" ? ( */}
          <Paid paidInvoices={paidInvoices} loading={stateLoading} />
          {/* ) : (
            currentSubNav === "unpaid" && (
              <Received
                unPaidInvoices={unPaidInvoices}
                loading={stateLoading}
                refetch={() => fetchUnpaid()}
              />
            )
          )} */}
        </Wrapper>
      </Box>
    </Box>
  );
};

export default Finance;

const SubNavItem = ({ title, isCurrent, handleClick }) => (
  // <Button>

  // </Button>
  <Button
    h={"10"}
    cursor={"pointer"}
    borderRadius={"none"}
    bg={"white "}
    className={`text-primary_yellow text-lg text-start ${
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
    // px={"6"}
    // py={"3"}
    borderBottomWidth={"2px"}
    borderBottomColor={isCurrent ? "dark_green" : "none"}
    onClick={handleClick}
  >
    {title}
  </Button>
);
