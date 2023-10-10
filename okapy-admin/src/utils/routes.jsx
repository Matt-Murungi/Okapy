import {
  Apps,
  Bookings,
  Dashboard,
  Finance,
  Fleet,
  Partners,
  SettingsPartner,
  SettingsUser,
  Users,
  ViewPartner,
  ViewUser,
} from "../pages";
import FleetView from "../pages/FleetView";
import ViewDriver from "../pages/ViewDriver";

export const routes = [
  {
    path: "/",
    element: <Dashboard />,
  },
  {
    path: "/bookings",
    element: <Bookings />,
  },
  {
    path: "/finance",
    element: <Finance />,
  },
  {
    path: "/applications",
    element: <Apps />,
  },
  {
    path: "/applications/:name",
    element: <ViewDriver />,
  },
  {
    path: "/fleet",
    element: <Fleet />,
  },
  {
    path: "/fleet/:plate",
    element: <FleetView />,
  },
  {
    path: "/partners",
    element: <Partners />,
  },

  {
    path: "/partners/:id",
    element: <ViewPartner />,
  },
  {
    path: "/users",
    element: <Users />,
  },

  {
    path: "/users/:id",
    element: <ViewUser />,
  },
  {
    path: "/users/driver/:id",
    element: <ViewDriver />,
  },
  {
    path: "/settings/users",
    element: <SettingsUser />,
  },
  {
    path: "/settings/partners",
    element: <SettingsPartner />,
  },
];
