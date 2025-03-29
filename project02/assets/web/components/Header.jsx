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
    <nav className="flex items-center justify-between w-full px-4 bg-indigo-300 relative">
      <Link href="/" className="text-lg font-bold p-4">
        Interstellar Guide
      </Link>

      {/* Mobile Menu Button */}
      <button
        className="md:hidden p-2 rounded-lg bg-indigo-600 text-white relative w-10 h-10 flex items-center justify-center"
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
        className={`fixed inset-0 bg-opacity-50 z-50 transition-opacity duration-300 ${isOpen ? "opacity-100 visible" : "opacity-0 invisible"
          }`}
        onClick={() => setIsOpen(false)}
      >
        <div
          className={`fixed top-0 left-0 w-64 h-full bg-indigo-300 shadow-lg transition-transform duration-300 ease-in-out transform ${isOpen ? "translate-x-0" : "-translate-x-full"
            } relative`}
          onClick={(e) => e.stopPropagation()}
        >
          {/* Sidebar Links */}
          <div className="flex flex-col p-6 space-y-4">
            <Link href="/" className="text-lg font-bold p-4">
              Interstellar Guide
            </Link>
            <Link href="/about" className="px-4 py-2 text-sm bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300">
              About
            </Link>
            <Link href="/docs" className="px-4 py-2 text-sm bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300">
              Docs
            </Link>
            <Link href="/features" className="px-4 py-2 text-sm bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300">
              Features
            </Link>
          </div>
        </div>
      </div>

      {/* Desktop Menu */}
      <div className="hidden md:flex gap-4">
        <Link href="/about" className="px-4 py-2 text-sm bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300">
          About
        </Link>
        <Link href="/docs" className="px-4 py-2 text-sm bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300">
          Docs
        </Link>
        <Link href="/features" className="px-4 py-2 text-sm bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300">
          Features
        </Link>
      </div>
    </nav>
  );
}
