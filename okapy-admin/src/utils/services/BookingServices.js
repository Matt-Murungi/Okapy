import AxiosUtility, { } from "../../core/services/AxiosService";

// login
async function fetchBookings() {
  if (localStorage.getItem("isPartner")) {
    const res = await AxiosUtility.get("/payments/api/owner/");
    return res.data;
  } else {

    const res = await AxiosUtility.get("/admins/api/orders/");
    return res.data;
  }

}

async function getBookingReceiver(booking_id) {
  const res = await AxiosUtility.get(
    "/bookings/api/receiver/" + booking_id + "/"
  );

  return res.data;
}

async function ownersBookings(id) {
  const res = await AxiosUtility.get(`/admins/api/orders/?owner__id=${id}`);

  return res.data;
}

async function getBookingsReceiver(id) {
  const res = await AxiosUtility.get(`/bookings/api/receiver/${id}`);

  return res.data;
}

const BookingServices = {
  fetchBookings,
  ownersBookings,
  getBookingsReceiver,
  getBookingReceiver,
};

export default BookingServices;