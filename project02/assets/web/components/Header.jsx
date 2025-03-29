"use client";

import { useState, useEffect } from "react";
import Image from "next/image";
import Link from "next/link";

export function Header() {
  const [isOpen, setIsOpen] = useState(false);

  useEffect(() => {
    document.body.classList.toggle("overflow-hidden", isOpen);
    return () => document.body.classList.remove("overflow-hidden");
  }, [isOpen]);

  return (
    <nav className="flex items-center justify-between w-full px-4 py-3 bg-indigo-300 relative">
      <Link href="/" className="text-lg font-bold">
        Interstellar Guide
      </Link>

      {/* Mobile Menu Button */}
      <button
        className="md:hidden p-2"
        onClick={() => setIsOpen(!isOpen)}
      >
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
        className={`fixed inset-0 z-50 transition-all duration-300 ease-in-out ${isOpen ? "opacity-100 visible" : "opacity-0 invisible"
          }`}
        onClick={() => setIsOpen(false)}
      >
        <div
          className={`fixed top-0 left-0 w-72 h-full bg-indigo-400 shadow-2xl transition-transform duration-300 ease-in-out transform ${isOpen ? "translate-x-0" : "-translate-x-full"
            }`}
          onClick={(e) => e.stopPropagation()}
        >
          {/* Sidebar Header */}
          <div className="flex items-center justify-between p-4 border-b border-indigo-100">
            <Link href="/" className="text-lg font-bold">
              Interstellar Guide
            </Link>
          </div>

          {/* Sidebar Links */}
          <div className="flex flex-col p-4 space-y-3">
            <Link
              href="/about"
              className="px-3 py-2 text-lg text-white bg-indigo-600 rounded-lg transition-colors duration-200 ease-in-out"
            >
              About
            </Link>
            <Link
              href="/docs"
              className="px-3 py-2 text-lg text-white bg-indigo-600 rounded-lg transition-colors duration-200 ease-in-out active:bg-blue-700"
            >
              Docs
            </Link>
            <Link
              href="/features"
              className="px-3 py-2 text-lg text-white bg-indigo-600 rounded-lg transition-colors duration-200 ease-in-out active:bg-blue-700"
            >
              Features
            </Link>
          </div>
        </div>
      </div>

      {/* Desktop Menu */}
      <div className="hidden md:flex gap-4">
        <Link
          href="/about"
          className="px-4 py-2 text-sm bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300 ease-in-out"
        >
          About
        </Link>
        <Link
          href="/docs"
          className="px-4 py-2 text-sm bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300 ease-in-out"
        >
          Docs
        </Link>
        <Link
          href="/features"
          className="px-4 py-2 text-sm bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300 ease-in-out"
        >
          Features
        </Link>
      </div>
    </nav>
  );
}