import AxiosUtility from "../../core/services/AxiosService";

// login
async function fetchPartners() {
  const res = await AxiosUtility.get("/partners/api/");

  return res.data;
}

async function fetchSinglePartner(id) {
  const res = await AxiosUtility.get("/partners/api/" + id + "/");

  return res.data;
}

async function createPartner(partner) {

  const res = await AxiosUtility.post("/partners/api/owner/", partner);
  return res?.data;

  // console.log(partner);
  // return "";
}

const PartnerServices = { fetchPartners, fetchSinglePartner, createPartner };

export default PartnerServices;
