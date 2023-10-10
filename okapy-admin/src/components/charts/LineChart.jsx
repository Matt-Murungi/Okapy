import React from "react";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
} from "recharts";
import { CustomTooltip } from "./CustomTooltip";

const data = [
  {
    name: "Jan",
    uv: 40,
    pv: 24,
    amt: 2400,
  },
  {
    name: "Feb",
    uv: 30,
    pv: 13,
    amt: 2210,
  },
  {
    name: "Mar",
    uv: 20,
    pv: 98,
    amt: 2290,
  },
  {
    name: "Apr",
    uv: 2780,
    pv: 39,
    amt: 2000,
  },
  {
    name: "May",
    uv: 1890,
    pv: 48,
    amt: 2181,
  },
  {
    name: "Jun",
    uv: 2390,
    pv: 38,
    amt: 2500,
  },
  {
    name: "Jul",
    uv: 3490,
    pv: 43,
    amt: 2100,
  },
  {
    name: "Aug",
    uv: 3490,
    pv: 24,
    amt: 2100,
  },
  {
    name: "Sep",
    uv: 3490,
    pv: 14,
    amt: 2100,
  },
  {
    name: "Oct",
    uv: 3490,
    pv: 18,
    amt: 2100,
  },
  {
    name: "Nov",
    uv: 3490,
    pv: 19,
    amt: 2100,
  },
  {
    name: "Dec",
    uv: 3490,
    pv: 66,
    amt: 2100,
  },
];

export function CustomLineChart() {
  return (
    <ResponsiveContainer width="100%" className={"m-auto"} height="90%">
      <LineChart
        width={500}
        height={300}
        data={data}
        margin={{
          top: 5,
          right: 30,
          left: 20,
          bottom: 5,
        }}
        color={"#ddd"}
      >
        <defs>
          <filter id="shadow" height="200%">
            <feGaussianBlur in="SourceAlpha" stdDeviation="7" result="blur" />
            <feOffset in="blur" dx="0" dy="7" result="offsetBlur" />
            <feFlood
              floodColor="#FB896B"
              floodOpacity="0.7"
              result="offsetColor"
            />
            <feComposite
              in="offsetColor"
              in2="offsetBlur"
              operator="in"
              result="offsetBlur"
            />
            <feMerge>
              <feMergeNode />
              <feMergeNode in="SourceGraphic" />
            </feMerge>
          </filter>
        </defs>
        <XAxis stroke="#45445960" dataKey="name" />
        <YAxis stroke="#45445960" />
        <Tooltip
          labelClassName="border-0 outline-0"
          content={<CustomTooltip />}
          //   position={{ y: -10 }}
        />
        {/* <Legend /> */}
        <Line
          filter="url(#shadow)"
          type="monotone"
          strokeWidth={"2"}
          dataKey="pv"
          stroke="#FB896B"
          activeDot={{ r: 6 }}
          dot={false}
          //   activeDot={false}
        />
        {/* <Line type="monotone" dataKey="uv" stroke="#82ca9d" /> */}
      </LineChart>
    </ResponsiveContainer>
  );
}
