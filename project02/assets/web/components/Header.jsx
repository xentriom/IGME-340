"use client";

import { useState } from "react";
import Image from "next/image";
import Link from "next/link";

export function Header() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <nav className="flex items-center justify-between w-full px-4 bg-indigo-300 relative">
      <Link href={"/"} className="text-lg font-bold p-4">
        Interstellar Guide
      </Link>

      <button
        className="md:hidden p-2 rounded-lg bg-indigo-600 text-white"
        onClick={() => setIsOpen(!isOpen)}
      >
        <Image
          src={isOpen ? "/cross.svg" : "/menu-alt.svg"}
          alt="Menu"
          width={24}
          height={24}
          className="transition-transform duration-300"
          style={{ transform: isOpen ? "rotate(90deg)" : "rotate(0deg)" }}
        />
      </button>

      {/* Sidebar Menu */}
      <div
        className={`fixed top-0 right-0 w-64 h-full bg-indigo-300 shadow-lg transition-transform duration-300 ${
          isOpen ? "translate-x-0" : "translate-x-full"
        } md:hidden pt-16`}
      >
        <button
          className="absolute top-4 right-4 p-2 rounded-lg bg-indigo-600 text-white"
          onClick={() => setIsOpen(false)}
        >
          <Image src="/cross.svg" alt="Close" width={24} height={24} />
        </button>
        <div className="flex flex-col p-6 space-y-4">
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