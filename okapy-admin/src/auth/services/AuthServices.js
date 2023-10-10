import AxiosUtility, { AxiosUtilityNoToken } from "../../core/services/AxiosService";

// login
async function login(data) {
  localStorage.clear();
  const res = await AxiosUtilityNoToken.post("auth/login/", data);

  return res.data;
}

// logout
async function logout() {
  const res = await AxiosUtility.post("/auth/logout/");
  console.log(res)

  localStorage.clear();
  return res.data;
}

// get user
async function getUser() {
  const res = await AxiosUtility.get("/auth/user/");

  if (res?.data.partner === 1) {
    localStorage.setItem("isPartner", true)
  }

  return res.data;
}

async function getProfiles() {
  const res = await AxiosUtility.get("/admins/api/profiles/");

  return res.data;
}

const auth = { login, logout, getUser, getProfiles };

export default auth;
