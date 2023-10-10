import AxiosUtility from "../../core/services/AxiosService";

// login
async function fetchEarnings() {
  const res = await AxiosUtility.get("/payments/api/payments/");

  return res.data;
}

async function fetchRequestEarnings() {

  const res = await AxiosUtility.get("admins/api/earnings/requests/");

  return res.data;
}

async function confirmPaymentRequest(id) {

  const res = await AxiosUtility.patch(
    "admins/api/earnings/request/update/" + id + "/",
    {
      status: 2,
    }
  );

  return res.data;
}

const EarningServices = {
  fetchEarnings,
  fetchRequestEarnings,
  confirmPaymentRequest,
};

export default EarningServices;
