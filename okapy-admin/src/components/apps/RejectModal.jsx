import { Textarea } from "@chakra-ui/react";
import React from "react";

import CustomModal from "../general/CustomModal";

import Wrapper from "../general/Wrapper";

const RejectModal = ({ openModal, handleCloseModal }) => {
  return (
    <CustomModal
      title="Reason to reject"
      isOpen={openModal}
      onClose={handleCloseModal}
      bg={"gray.100"}
      px={0}
      showHeader={false}
      hfs={"md"}
      ofy={"hidden"}
      showConfirm
    >
      <Wrapper borderRadius={0} px={"7"}>
        <Textarea minH={300} borderColor={"primary_yellow"} />
      </Wrapper>
    </CustomModal>
  );
};

export default RejectModal;
