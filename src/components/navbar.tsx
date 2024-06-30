import React from "react";
import { Link } from "react-router-dom";

// @ts-ignore
import logo from "../assets/icon/observatory_ios.png";

function MenuItems() {
  return (
    <>
      <li>
        <a href="https://github.com/benjamindean/observatory" target="_blank">
          GitHub
        </a>
      </li>
      <li>
        <Link to="/observatory/privacy-policy">Privacy Policy</Link>
      </li>
      <li>
        <Link to="/observatory/terms-and-conditions">Terms & Conditions</Link>
      </li>
    </>
  );
}

export default function NavBar() {
  return (
    <div className="navbar bg-base-100">
      <div className="navbar-start">
        <div className="dropdown">
          <div tabIndex={0} role="button" className="btn btn-ghost lg:hidden">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              className="h-5 w-5"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M4 6h16M4 12h8m-8 6h16"
              />
            </svg>
          </div>
          <ul
            tabIndex={0}
            className="menu menu-sm dropdown-content bg-base-100 rounded-box z-[1] mt-3 w-52 p-2 shadow"
          >
            <MenuItems />
          </ul>
        </div>

        <a className="btn btn-ghost text-xl" href="/observatory">
          <div className="avatar pr-1">
            <div className="w-10 h-10 rounded-full">
              <img src={logo} />
            </div>
          </div>
          Observatory
        </a>
      </div>
      <div className="navbar-center hidden lg:flex">
        <ul className="menu menu-horizontal px-1">
          <MenuItems />
        </ul>
      </div>
      <div className="navbar-end"></div>
    </div>
  );
}
