import axios from "axios";

export const ENDPOINT = "http://127.0.0.1:8000/";
// export const ENDPOINT = "https://api.okapy.world/";
// export const ENDPOINT = "https://apidev.okapy.world/";
const BASE_URL = ENDPOINT;

const AxiosUtility = axios.create({
  baseURL: `${BASE_URL}`,
  timeout: 10000,
  headers: {
    "Content-Type": "application/json",
  },
});

export const setAuthToken = async (instance) => {
  const { state } = await JSON.parse(localStorage?.getItem("okapy_user"));
  const token = state?.user?.token;

  if (token) {
    instance.defaults.headers.common["Authorization"] = `Token ${token}`;
  } else {
    delete instance.defaults.headers.common["Authorization"];
  }
};

export default AxiosUtility;
