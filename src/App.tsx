import React from "react";
import NavBar from "./components/navbar.tsx";

import { Outlet } from "react-router-dom";

export default function App() {
  return (
    <div className="justify-center">
      <NavBar />
      <Outlet />

      <footer className="footer footer-center bg-base-300 text-base-content p-4">
        <aside>
          <p>Copyright © {new Date().getFullYear()} - All right reserved</p>
        </aside>
      </footer>
    </div>
  );
}
