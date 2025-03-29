import Link from "next/link";

export function Header() {
  return (
    <nav className="flex items-center justify-between w-full px-4 bg-indigo-300">
      <div className="text-lg font-bold p-4">HSR - Interstellar Guides</div>
      <Link href="/features" className="px-4 py-2 text-sm bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-colors duration-300">
        Explore Features
      </Link>
    </nav>
  );
}