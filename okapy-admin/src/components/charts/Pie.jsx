import React from "react";
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from "chart.js";
import { Pie } from "react-chartjs-2";

ChartJS.register(ArcElement, Tooltip, Legend);

const options = {
  plugins: {
    legend: {
      display: false,
    },
  },
};

export const data = {
  labels: ["Red", "Blue"],
  datasets: [
    {
      label: "# of Votes",
      data: [12, 19],
      backgroundColor: ["#16AC52", "#2DFC3430"],
      // borderColor: [
      //   "rgba(255, 99, 132, 1)",
      //   "rgba(54, 162, 235, 1)",
      //   "rgba(255, 206, 86, 1)",
      //   "rgba(75, 192, 192, 1)",
      //   "rgba(153, 102, 255, 1)",
      //   "rgba(255, 159, 64, 1)",
      // ],
      borderWidth: 1,
    },
  ],
};

export function CustomPie() {
  return <Pie data={data} options={options} />;
}
