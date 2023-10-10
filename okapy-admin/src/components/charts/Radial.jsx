import React from "react";
import {
  RadialBarChart,
  RadialBar,
  ResponsiveContainer,
  PolarAngleAxis,
} from "recharts";

// { text: "", color: "#16AC52" },
// { text: "", color: "#EAC625" },
// { text: "", color: "#D9D9D9" },
// { text: "", color: "#BB1600" },
const data = [
  {
    name: "very dissatisfied",
    uv: 25,
    pv: 2400,
    fill: "#CD3234",
  },
  {
    name: "dissatisfied",
    uv: 20,
    pv: 4567,
    fill: "#D9D9D9",
  },
  {
    name: "satisified",
    uv: 25,
    pv: 1398,
    fill: "#EAC625",
  },
  {
    name: "very satisified",
    uv: 45,
    pv: 20,
    fill: "#16AC52",
  },
];

export default function RadialChart() {
  return (
    <ResponsiveContainer width="100%" height="100%">
      <RadialBarChart
        cx="50%"
        cy="50%"
        innerRadius="10%"
        outerRadius="85%"
        barSize={20}
        data={data}
        startAngle={90}
        endAngle={450}
      >
        {/* <Legend content={renderLegend} layout={"horizontal"} align="center" po /> */}

        <PolarAngleAxis
          type="number"
          domain={[0, 100]}
          angleAxisId={0}
          tick={false}
          label={false}
        />

        <RadialBar
          minAngle={20}
          label={false}
          background
          clockWise
          dataKey="uv"
          dominantBaseline={"pv"}
        />
      </RadialBarChart>
    </ResponsiveContainer>
  );
}
