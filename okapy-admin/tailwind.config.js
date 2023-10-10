/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      fontFamily: {
        Rubik: ["Rubik", "sans-serif"],
      },
      colors: {
        dark_green: "#1A411D", //text color, avatar
        current_bg: "#FFF6DC",
        requests_txt: "#9F7701",
        picked_bg: "#3EC3FF26", //15%
        picked_txt: "#0872A2",
        completed_bg: "#16FF1E26",
        completed_txt: "#28A745",
        cancelled_bg: "#FFA8A730",
        cancelled_txt: "#A0041E",
        primary_yellow: "#EFAF1D",
        primary_yellow_light: "#F2C914FA",
        primary_green: "#00A406",
        primary_red: "#CE3234",
        primary_red_light: "#F800001A",
        chart_primary: "#7B61FF",
        chart_secondary: "#FF9673",
      },
    },
  },
  plugins: [],
};
