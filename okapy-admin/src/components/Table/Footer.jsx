import { Box, Button, Center } from "@chakra-ui/react";
import React, { useEffect } from "react";
import { BsChevronLeft, BsChevronRight } from "react-icons/bs";

const TableFooter = ({ range, setPage, page, slice }) => {
  useEffect(() => {
    // console.log("RANGE:", range);
    if (slice?.length < 1 && page !== 1) {
      setPage(page - 1);
    }
  }, [slice, page, setPage]);
  return (
    <tr className="flex justify-end gap-1 p-1">
      {/* {range.map((el, index) => ( */}

      <Button
        bg={"white"}
        fontSize={"xl"}
        disabled={page <= 1}
        p={"2"}
        color={"dark_green"}
        onClick={() => setPage((prev) => parseInt(prev) - 1)}
      >
        <BsChevronLeft />
      </Button>

      <Center
        h={"8"}
        px={"3"}
        my={"1"}
        borderWidth={"1px"}
        bg={"white"}
        borderColor={"dark_green"}
        className={"rounded"}
        fontSize={"sm"}
        fontWeight={"medium "}
      >
        {page}
      </Center>

      <Button
        bg={"white"}
        fontSize={"xl"}
        p={"2"}
        disabled={page >= range?.length}
        onClick={() => setPage((prev) => parseInt(prev) + 1)}
      >
        <BsChevronRight color={"dark_green"} />
      </Button>

      <Box className="text-gray-400 my-auto px-2 text-sm border ">
        {page} / {range.length} pages
      </Box>
      {/* <button
          key={index}
          className={`${styles.button} ${
            page === el ? styles.activeButton : styles.inactiveButton
          }`}
          onClick={() => setPage(el)}
        >
          {el}
        </button> */}
      {/* ))} */}
    </tr>
  );
};

export default TableFooter;
