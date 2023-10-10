import React from "react";

const PrimaryButton = ({ children, handleClick, className, ...rest }) => {
  return (
    <button
      onClick={handleClick}
      className={` bg-primary_yellow border-[1.5px] border-primary_yellow text-sm rounded-md items-center flex gap-2 px-4 py-3 ${className}`}
      {...rest}
    >
      {children}
    </button>
  );
};

export default PrimaryButton;
