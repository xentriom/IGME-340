import Link from "next/link";

export const metadata = {
  title: "Credits",
};

export default function CreditsPage() {
  return (
    <div className="container mx-auto px-4 py-12 max-w-4xl">
      <h1 className="text-3xl md:text-5xl font-bold text-indigo-900 mb-8 text-center">
        Credits & Acknowledgments
      </h1>

      <div className="space-y-4">
        {/* App Section */}
        <section className="bg-blue-100/80 rounded-xl p-6 shadow-sm border border-gray-200/50">
          <h2 className="text-2xl font-semibold text-indigo-800 mb-4">App Assets & Resources</h2>
          <ul className="space-y-2 text-indigo-700">
            <li>Framework - Flutter (Cupertino Design)</li>
            <li>API - sr.yatta.moe</li>
            <li>Tutorials - Dower Chin, 340 professor</li>
            <li>Resources -
              <Link href="https://docs.flutter.dev/ui/widgets/cupertino" className="hover:underline">Flutter Cupertino Widgets Doc</Link>
            </li>
          </ul>
        </section>

        {/* Web Section */}
        <section className="bg-blue-100/80 rounded-xl p-6 shadow-sm border border-gray-200/50">
          <h2 className="text-2xl font-semibold text-indigo-800 mb-4">Web Assets & Resources</h2>
          <ul className="space-y-2 text-indigo-700">
            <li>Framework -&nbsp;
              <Link href="https://nextjs.org" className="hover:underline">Next.js</Link> &&nbsp;
              <Link href="https://tailwindcss.com" className="hover:underline">Tailwind CSS</Link>
            </li>
            <li>Typeface - <Link href="https://vercel.com/geist/icons" className="hover:underline">Geist Sans</Link>&nbsp;by Vercel</li>
            <li>Icons - <Link href="https://vercel.com/font" className="hover:underline">Geist Icon Set</Link>&nbsp;by Vercel</li>
          </ul>
        </section>

        {/* Acknowledgment */}
        <section className="text-center text-indigo-700">
          <p className="mt-2">Created for IGME 340's Project 02</p>
        </section>
      </div>
    </div>
  );
}