"use client";

import { useState, useEffect } from "react";
import { usePathname } from "next/navigation";
import Image from "next/image";
import Link from "next/link";

const linkClasses = {
  mobile: {
    base: "px-3 py-2 text-lg rounded-md transition-colors",
    active: "bg-indigo-700 text-white border-l-4 border-blue-100 font-medium",
    inactive: "pl-4 text-indigo-100 hover:bg-indigo-600 hover:text-white",
  },
  desktop: "px-4 py-2 text-sm bg-indigo-600 rounded-lg hover:bg-blue-500 transition-colors duration-300 ease-in-out",
};

const sidebarClasses = {
  overlay: "fixed inset-0 z-50 transition-all duration-300 ease-in-out",
  sidebar: "fixed top-0 left-0 w-72 h-full bg-indigo-500 shadow-2xl transition-transform duration-300 ease-in-out transform",
};

/**
 * Get the class name for the link based on the current path
 * @param {string} path - The path to check
 * @param {string} currentPath - The current path
 * @returns {string} The class name for the link
 */
const getLinkClass = (path, currentPath) => {
  const base = linkClasses.mobile.base;
  return path === currentPath
    ? `${base} ${linkClasses.mobile.active}`
    : `${base} ${linkClasses.mobile.inactive}`;
};

export function Header() {
  const [isOpen, setIsOpen] = useState(false);
  const pathname = usePathname();

  useEffect(() => {
    document.body.classList.toggle("overflow-hidden", isOpen);
    return () => document.body.classList.remove("overflow-hidden");
  }, [isOpen]);

  // Navigation items
  const navItems = [
    { path: "/", label: "Home" },
    { path: "/about", label: "About" },
    { path: "/docs", label: "Documentation" },
    { path: "/features", label: "Features" },
  ];

  return (
    <nav className="flex items-center justify-between w-full px-4 py-3 bg-indigo-300 relative">
      <Link href="/" className="text-lg font-bold">
        Interstellar Guide
      </Link>

      {/* Mobile Menu Button */}
      <button className="md:hidden" onClick={() => setIsOpen(!isOpen)}>
        <Image
          src={isOpen ? "/cross.svg" : "/menu-alt.svg"}
          alt={isOpen ? "Close Menu" : "Open Menu"}
          width={24}
          height={24}
          className="transition-transform duration-300 ease-in-out"
        />
      </button>

      {/* Sidebar & Overlay */}
      <div
        className={`${sidebarClasses.overlay} ${
          isOpen ? "opacity-100 visible" : "opacity-0 invisible"
        }`}
        onClick={() => setIsOpen(false)}
      >
        <div
          className={`${sidebarClasses.sidebar} ${
            isOpen ? "translate-x-0" : "-translate-x-full"
          }`}
          onClick={(e) => e.stopPropagation()}
        >
          {/* Sidebar Header */}
          <div className="flex items-center justify-between p-4 border-indigo-100">
            <Link href="/" className="text-xl font-bold text-white">
              Interstellar Guide
            </Link>
          </div>

          {/* Divider */}
          <hr className="border-t border-indigo-400 mx-4" />

          {/* Sidebar Links */}
          <div className="flex flex-col px-4 py-4 space-y-2">
            {navItems.map((item) => (
              <Link
                key={item.path}
                href={item.path}
                className={getLinkClass(item.path, pathname)}
              >
                {item.label}
              </Link>
            ))}
          </div>
        </div>
      </div>

      {/* Desktop Menu */}
      <div className="hidden md:flex gap-4 text-white">
        {navItems
          .filter((item) => item.path !== "/")
          .map((item) => (
            <Link
              key={item.path}
              href={item.path}
              className={linkClasses.desktop}
            >
              {item.label}
            </Link>
          ))}
      </div>
    </nav>
  );
}