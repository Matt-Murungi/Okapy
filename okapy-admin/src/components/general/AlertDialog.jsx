import {
  AlertDialogBody,
  AlertDialogContent,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogOverlay,
  Button,
  useDisclosure,
} from "@chakra-ui/react";
import React from "react";

function AlertDialog({
  body,
  title,
  btn_text,
  color = "red",
  handleConfirm,
  isOpen,

  onClose,
  // ...rest
}) {
  // const { isOpen, onOpen, onClose } = useDisclosure();
  // const cancelRef = React.useRef();

  return (
    <AlertDialog
      isOpen={isOpen}
      // leastDestructiveRef={cancelRef}
      onClose={onClose}
    >
      <AlertDialogOverlay>
        <AlertDialogContent>
          <AlertDialogHeader fontSize="md" fontWeight="bold">
            {title}
          </AlertDialogHeader>

          <AlertDialogBody fontSize={"sm"}>{body}</AlertDialogBody>

          <AlertDialogFooter>
            <Button fontSize={"sm"} onClick={onClose}>
              Cancel
            </Button>
            <Button colorScheme={color} onClick={handleConfirm} ml={3}>
              Delete
            </Button>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialogOverlay>
    </AlertDialog>
  );
}

export default AlertDialog;
