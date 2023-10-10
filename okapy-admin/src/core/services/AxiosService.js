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
    "Authorization": `Token ${localStorage.getItem("token")}`
  },
});

export const AxiosUtilityNoToken = axios.create({
  baseURL: `${BASE_URL}`,
  timeout: 10000,
  headers: {
    "Content-Type": "application/json",
  },
});



export default AxiosUtility;
