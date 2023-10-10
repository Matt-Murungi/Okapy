import React from "react";

const Avatar = ({ text }) => {
  return (
    <div class="inline-flex overflow-hidden relative justify-center items-center w-10 h-10 bg-dark_green rounded-full dark:bg-gray-600">
      <span class="font-semibold text-xl text-primary_yellow dark:text-gray-300">
        {text}
      </span>
    </div>
  );
};

export default Avatar;
