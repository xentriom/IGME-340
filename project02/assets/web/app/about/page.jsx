import Link from "next/link";

export const metadata = {
  title: "About",
};

export default function AboutPage() {
  return (
    <div className="container mx-auto px-4 py-12 max-w-5xl">
      {/* Hero Section */}
      <section className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-bold mb-4 animate-in fade-in">
          About Interstellar Guide
        </h1>
        <p className="text-lg text-indigo-700 max-w-2xl mx-auto animate-in fade-in duration-700 delay-100">
          A solo passion project created to enhance your Honkai: Star Rail experience.
        </p>
      </section>

      {/* About Me Section */}
      <section className="grid md:grid-cols-2 gap-8 mb-12">
        <div className="bg-blue-100/80 backdrop-blur-md rounded-xl p-6 border border-gray-200/50 shadow-lg">
          <h2 className="text-2xl font-semibold text-indigo-800 mb-2">The Story</h2>
          <p className="text-indigo-700 leading-relaxed">
            This app as part of IGME 340 Project 02. My goal was to build a companion tool that will assist players as they continue to learn about the game and characters.
          </p>
        </div>
        <div className="text-center bg-gradient-to-r from-indigo-100 to-purple-100 rounded-xl p-6">
          <div className="text-indigo-800">
            <h3 className="text-xl font-semibold mb-4">Quick Facts</h3>
            <ul className="space-y-2 text-left">
              <li>• Started: March 07, 2025</li>
              <li>• Creator: Jason Chen</li>
              <li>• Version: 1.0.0</li>
            </ul>
          </div>
        </div>
      </section>

      {/* Project Vision */}
      <section className="mb-12 bg-blue-100/80 backdrop-blur-md rounded-xl p-6 border border-gray-200/50 shadow-lg">
        <p className="text-indigo-700 leading-relaxed text-center max-w-3xl mx-auto">
          Interstellar Guide is more than just a school project — it's designed to help players like me navigate the vast universe of Honkai: Star Rail. From real-time character tracking to customizable settings.
        </p>
      </section>

      {/* CTA Section */}
      <section className="text-center bg-gradient-to-r from-indigo-100 to-purple-100 rounded-xl p-6">
        <p className="text-indigo-700 mb-4 mx-auto">
          Have feedback or ideas? I'd love to hear from you as I continue to improve this app!
        </p>
        <Link
          href="/contact"
          className="inline-block bg-indigo-600 text-white px-4 py-3 rounded-lg 
            hover:bg-indigo-700 transition-colors duration-300"
        >
          Contact Me
        </Link>
      </section>
    </div>
  );
}