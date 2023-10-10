import React from "react";

const PrimaryOutlinedButton = ({ children, handleClick, className }) => {
  return (
    <button
      onClick={handleClick}
      className={`  border-[1.5px] border-primary_yellow rounded-md items-center flex gap-2 px-5 py-2.5 ${className}`}
    >
      {children}
    </button>
  );
};

export default PrimaryOutlinedButton;
