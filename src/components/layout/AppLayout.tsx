import Sidebar from "../sidebar/Sidebar";
import { Outlet, useNavigate } from "react-router-dom";
import "./appLayout.css";

import { useTranslation } from "react-i18next";
import INavItem from "../../services/sideBar/INavItems";

const AppLayout = () => {
  const sidebarNavItems: INavItem[] = [
    {
      display: "Students",
      icon: <i className="bx bx-body"></i>,
      to: "/students",
      section: "students",
      rolesAllowed: ["secretary", "admin"],
      isVisible: JSON.parse(
        process.env.REACT_APP_UI_NAVITEM_STUDENTS_ISVISIBLE!
      ),
    },
    {
      display: "Courses",
      icon: <i className="bx bx-book"></i>,
      to: "/courses",
      section: "courses",
      rolesAllowed: ["secretary", "admin"],
      isVisible: JSON.parse(
        process.env.REACT_APP_UI_NAVITEM_COURSES_ISVISIBLE!
      ),
    },
    {
      display: "Groups",
      icon: <i className="bx bx-group"></i>,
      to: "/groups",
      section: "groups",
      rolesAllowed: ["secretary", "admin"],
      isVisible: JSON.parse(process.env.REACT_APP_UI_NAVITEM_GROUPS_ISVISIBLE!),
    },
    {
      display: "Cashflow",
      icon: <i className="bx bx-money"></i>,
      to: "/cashflow",
      section: "cashflow",
      rolesAllowed: ["secretary", "admin"],
      isVisible: JSON.parse(
        process.env.REACT_APP_UI_NAVITEM_CASHFLOW_ISVISIBLE!
      ),
    },
    {
      display: "Reports",
      icon: <i className="bx bx-line-chart"></i>,
      to: "/reports",
      section: "reports",
      rolesAllowed: ["admin"],
      isVisible: JSON.parse(
        process.env.REACT_APP_UI_NAVITEM_REPORTS_ISVISIBLE!
      ),
    },
    {
      display: "SignUp",
      icon: <i className="bx bx-log-in-circle"></i>,
      to: "/SignUp",
      section: "SignUp",
      rolesAllowed: ["admin"],
      isVisible: JSON.parse(process.env.REACT_APP_UI_NAVITEM_SIGNUP_ISVISIBLE!),
    },
  ];

  const [t, i18n] = useTranslation();

  return (
    <div className="d-flex flex-row">
      <div className="col-3">
        <Sidebar
          sidebarNavItems={sidebarNavItems.filter(
            (navItem) => navItem.isVisible === true
          )}
        />
      </div>
      <div className="d-flex flex-column outlet">
        <div>
          <Outlet />
        </div>
        <div className="outletDropdown">
          <div className="switch">
            <input
              id="language-toggle"
              className="check-toggle check-toggle-round-flat"
              type="checkbox"
              onChange={(e) =>
                e.target.checked === true
                  ? i18n.changeLanguage("en")
                  : i18n.changeLanguage("es")
              }
            />
            <label htmlFor="language-toggle"></label>
            <span className="on">ESP</span>
            <span className="off">ENG</span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default AppLayout;
