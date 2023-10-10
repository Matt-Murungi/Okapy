import { useQuery } from "react-query";
import BookingServices from "../utils/services/BookingServices";

export const useBookingsData = (handleSuccess, handleError) => {
  return useQuery(["bookings"], BookingServices.fetchBookings, {
    handleSuccess,
    handleError,
  });
};
