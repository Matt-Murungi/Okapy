import { useQuery } from "react-query";
import UserServices from "../utils/services/UserServices";

export const useUsers = (params, handleSuccess, handleError) => {
  return useQuery(["users"], () => UserServices.fetchUsers(params), {
    handleSuccess,
    handleError,
  });
};
