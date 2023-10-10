import AxiosUtility from "../../core/services/AxiosService";

// login
async function fetchUsers() {
  const res = await AxiosUtility.get("/admins/api/users/");

  return res.data;
}

async function fetchDrivers(cond) {
  const res = await AxiosUtility.get(
    "/admins/api/profiles/?is_approved=" + cond
  );

  return res.data;
}

async function createUser(data) {
  const res = await AxiosUtility.post("/auth/registration/", data);

  return res.data;
}

async function updateUser(data) {
  const res = await AxiosUtility.patch(`/admins/api/user/update/`, data);

  return res.data;
}

async function ApproveDriver(id) {
  const res = await AxiosUtility.patch("admins/api/update/profile/", {
    is_approved: true,
    id,
  });

  return res.data;
}

async function createDriver(data) {
  const res = await AxiosUtility.post(
    "/users/api/user/driver/registration/",
    data
  );

  return res.data;
}

async function deleteUser(id) {
  const res = await AxiosUtility.delete("/users/api/user/delete/", { id });

  return res.data;
}

async function getDriverBankDetails(id) {
  // https://apidev.okapy.world/admins/api/driver/banking/information/74/
  const res = await AxiosUtility.get(
    "/admins/api/driver/banking/information/" + id + "/"
  );

  return res.data;
}

const UserServices = {
  ApproveDriver,
  fetchUsers,
  createUser,
  updateUser,
  createDriver,
  fetchDrivers,
  deleteUser,
  getDriverBankDetails,
};

export default UserServices;
