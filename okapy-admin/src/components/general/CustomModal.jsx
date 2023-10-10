import {
  Modal,
  ModalBody,
  ModalCloseButton,
  ModalContent,
  ModalFooter,
  ModalHeader,
  ModalOverlay,
  Text,
} from "@chakra-ui/react";
import React from "react";
import LoadingButton from "./LoadingButton";
import PrimaryButton from "./PrimaryButton";
import PrimaryOutlinedButton from "./PrimaryOutlinedButton";

const CustomModal = ({
  isOpen,
  onClose,
  button,
  title = "Modal Title",
  children,
  bg = "white",
  px,
  hfs,
  ofy = "hidden", //overflowY
  showConfirm = false,
  handleSave,
  loading,
  hideSave = false,
}) => {
  return (
    <>
      {button}
      <Modal size={"xl"} isOpen={isOpen} onClose={onClose}>
        <ModalOverlay />
        <ModalContent maxH={"90vh"} bg={bg} className="w-1/2">
          <ModalHeader fontSize={hfs} py={"3"}>
            {title}
          </ModalHeader>
          <ModalCloseButton />
          <ModalBody overflowY={ofy} h={"90%"} py={0} px={px}>
            {children}
          </ModalBody>

          <ModalFooter className="flex gap-3 bg-white">
            {!showConfirm && (
              <>
                <PrimaryOutlinedButton
                  handleClick={onClose}
                  className={"text-sm items-end px-10"}
                >
                  <Text color={"primary_yellow"} fontWeight={"medium"}>
                    Cancel
                  </Text>
                </PrimaryOutlinedButton>

                {!hideSave && (
                  <>
                   { !loading ? (
                    <PrimaryButton
                      handleClick={handleSave}
                      className={"text-sm items-end px-10"}
                    >
                      <Text fontWeight={"medium"}>Save</Text>
                    </PrimaryButton>
                    ) : (
                    <LoadingButton
                      borderRadius={"md"}
                      fontSize={"14px"}
                      // w={"75%"}
                      h={"12"}
                    />
                    )}
                  </>
                )}
              </>
            )}

            {showConfirm && (
              <PrimaryButton className={"text-sm items-end px-8 h-10"}>
                <Text fontWeight={"medium"}>Confirm</Text>
              </PrimaryButton>
            )}
          </ModalFooter>
        </ModalContent>
      </Modal>
    </>
  );
};

export default CustomModal;
