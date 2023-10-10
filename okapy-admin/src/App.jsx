import "./App.css";
import { ChakraProvider } from "@chakra-ui/react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import { routes } from "./utils/routes";
import { extendTheme } from "@chakra-ui/react";
import { colors, font, styles } from "./assets/Theme";
import PanelLayout from "./components/PanelLayout";
import PrivateRoute from "./utils/PrivateRoute";
import { QueryClient, QueryClientProvider } from "react-query";
import { createContext, useState } from "react";

export const UserContext = createContext({});

function App() {
  const theme = extendTheme({
    colors: colors,
    fonts: {
      body: font,
    },
    styles: {
      global: styles,
    },
  });

 const [currentUser, setCurrentUser] = useState(null);
  const queryClient = new QueryClient();

  return (
    <ChakraProvider theme={theme}>
      <BrowserRouter>
        <QueryClientProvider client={queryClient}>
          <PrivateRoute>
              <UserContext.Provider value={{currentUser, setCurrentUser}}>
            <PanelLayout>
                <Routes>
                  {routes.map((route, key) => (
                    <Route
                      key={key}
                      exact
                      path={route?.path}
                      element={route?.element}
                    />
                    ))}
                    </Routes>
            </PanelLayout>
              </UserContext.Provider>
          </PrivateRoute>
        </QueryClientProvider>
      </BrowserRouter>
    </ChakraProvider>
  );
}

export default App;
