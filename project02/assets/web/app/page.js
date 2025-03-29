import Link from "next/link";

export default function Home() {
  return (
    <div className="flex flex-col items-center justify-center px-4 py-12">
      {/* Hero Section */}
      <section className="text-center max-w-2xl">
        <h1 className="text-4xl md:text-5xl font-bold mb-6">
          Interstellar Guides
        </h1>
        <p className="text-lg text-indigo-700 mb-8">
          Your ultimate companion for exploring the universe of Honkai: Star Rail
        </p>
        <div className="flex gap-4 justify-center">
          <Link href="/features" className="px-6 py-3 bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300">
            Explore Features
          </Link>
          <Link href="/features" className="px-6 py-3 bg-transparent border border-indigo-600 text-indigo-600 rounded-lg hover:bg-blue-100 transition-colors duration-300">
            View Docs
          </Link>
        </div>
      </section>

      {/* Features Preview */}
      <section className="mt-16 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6 px-4 max-w-4xl">
        {[
          { title: "Account Creation", desc: "Personalize your cosmic journey with your own account" },
          { title: "Character Preview", desc: "Explore detailed insights for every character" },
          { title: "Bookmarking", desc: "Save your favorite characters for future adventures" }
        ].map(({ title, desc }, index) => (
          <div key={index} className="p-6 bg-blue-50 rounded-lg shadow-md hover:shadow-lg transition-shadow">
            <h3 className="text-xl font-semibold mb-2">{title}</h3>
            <p className="text-indigo-600">{desc}</p>
          </div>
        ))}
      </section>
    </div>
  );
}