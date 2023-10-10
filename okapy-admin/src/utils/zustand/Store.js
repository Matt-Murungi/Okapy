import create from "zustand";
import { devtools, persist } from "zustand/middleware";

const useUserStore = create(
  devtools(
    persist(
      (set) => ({
        user: {
          token: null,
        },
        setToken: (tkn) =>
          set((state) => ({ user: { ...state.user, token: tkn } })),
      }),
      { name: "okapy_user" }
    )
  )
);

export default useUserStore;
