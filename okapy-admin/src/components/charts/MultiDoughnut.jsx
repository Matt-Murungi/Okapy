import React from "react";
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from "chart.js";
import { Doughnut } from "react-chartjs-2";

ChartJS.register(ArcElement, Tooltip, Legend);

const options = {
  plugins: {
    centerText: {
      display: true,
      text: "90%",
    },
    legend: {
      display: false,
      position: "bottom",
    },
  },
};

export const data = {
  labels: ["Very satisfied", "Satisfied", "Dissatisfied", "Very dissatisfied"],
  datasets: [
    {
      label: "# of Votes",
      data: [
        Math.random() * 20,
        Math.random() * 30,
        Math.random() * 40,
        Math.random() * 50,
      ],
      backgroundColor: ["#16AC52", "#EAC625", "#D9D9D9", "#BB1600"],
    },
  ],
  text: "40",
};

export function MultiDoughnut() {
  return <Doughnut data={data} options={options} />;
}
