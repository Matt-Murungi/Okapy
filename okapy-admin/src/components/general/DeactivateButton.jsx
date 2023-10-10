import React from "react";

const DeactivateButton = ({ children, handleClick, className }) => {
  return (
    <div
      onClick={handleClick}
      className={`  rounded-md items-center flex gap-2 px-5 py-2.5 ${className}`}
    >
      {children}
    </div>
  );
};

export default DeactivateButton;