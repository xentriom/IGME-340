export function Footer() {
  return (
    <footer className="flex flex-col items-center justify-center w-full py-4 bg-indigo-300">
      <div className="text-sm">
        © {new Date().getFullYear()} Interstellar Guide. All rights reserved.
      </div>
    </footer>
  );
}