import { Box } from "@chakra-ui/react";

export const CustomTooltip = ({ active, payload, label }) => {
  if (active && payload && payload.length) {
    return (
      <Box className="outline-none focus:outline-0 border-white bg-white w-32 rounded-xl overflow-hidden shadow-2xl">
        <div className="p-1 bg-gray-100 text-center">{label}</div>
        <div className="label p-3 flex items-center gap-2">
          <div className={`h-4 w-4 rounded-full bg-[#FB896B]`} />
          {`kshs ${payload[0].value}`}
        </div>
        {/* <div>
          {payload.map((pld) => (
            <div style={{ display: "inline-flex", padding: 10 }}>
              <div style={{ color: pld.fill }}>{pld.value}</div>
            </div>
          ))}
        </div> */}
      </Box>
    );
  }

  return null;
};
