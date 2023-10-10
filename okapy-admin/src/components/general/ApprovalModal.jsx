import {
  AlertDialogBody,
  AlertDialog,
  AlertDialogContent,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogOverlay,
  Button,
  useDisclosure,
  Text,
} from "@chakra-ui/react";
import React from "react";
function ApprovalModal({ isOpen, onOpen, onClose }) {
  //   const  = useDisclosure();
  const cancelRef = React.useRef();

  return (
    <>
      <button
        onClick={onOpen}
        className="bg-primary_yellow rounded-md items-center flex gap-2 px-16 py-3"
      >
        <Text fontWeight={"semibold"}>Approve</Text>
      </button>

      <AlertDialog
        isOpen={isOpen}
        leastDestructiveRef={cancelRef}
        onClose={onClose}
      >
        <AlertDialogOverlay>
          <AlertDialogContent>
            <AlertDialogHeader fontSize="lg" fontWeight="bold">
              Delete Customer
            </AlertDialogHeader>

            <AlertDialogBody>
              Are you sure? You can't undo this action afterwards.
            </AlertDialogBody>

            <AlertDialogFooter>
              <Button ref={cancelRef} onClick={onClose}>
                Cancel
              </Button>
              <Button colorScheme="red" onClick={onClose} ml={3}>
                Delete
              </Button>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialogOverlay>
      </AlertDialog>
    </>
  );
}

export default ApprovalModal;
