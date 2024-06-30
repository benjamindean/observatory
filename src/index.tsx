import React from "react";
import ReactDOM from "react-dom/client";
import { createBrowserRouter, RouterProvider } from "react-router-dom";

import Main from "./pages/Main.tsx";
import App from "./App.tsx";
import "./index.css";
import PrivacyPolicy from "./pages/PrivacyPolicy.tsx";
import TermsAndConditions from "./pages/TermsAndConditions.tsx";

const router = createBrowserRouter([
  {
    path: "/observatory",
    element: <App />,
    children: [
      {
        path: "/observatory",
        element: <Main />,
      },
      {
        path: "/observatory/privacy-policy",
        element: <PrivacyPolicy />,
      },
      {
        path: "/observatory/terms-and-conditions",
        element: <TermsAndConditions />,
      },
    ],
  },
]);

const root = ReactDOM.createRoot(document.getElementById("root") as any);

root.render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>
);
