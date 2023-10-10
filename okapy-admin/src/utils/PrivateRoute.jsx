import React from "react";
import { Login } from "../pages";

import useUserStore from "./zustand/Store";

const PrivateRoute = ({ children }) => {
  const user = useUserStore((state) => state.user);

  return user.token ? <>{children}</> : <Login />;
};

export default PrivateRoute;
