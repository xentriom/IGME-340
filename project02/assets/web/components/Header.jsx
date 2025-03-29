export function Header() {
  return (
    <header className="flex items-center justify-between w-full p-4 bg-gray-800 text-white">
      <div className="text-lg font-bold">Interstellar Guide</div>
      <nav className="flex space-x-4">
        <a href="/" className="hover:underline">
          Home
        </a>
      </nav>
    </header>
  );
}