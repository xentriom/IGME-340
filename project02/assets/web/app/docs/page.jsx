import { redirect } from "next/navigation";

async function handleDocClick(formData) {
  "use server";
  const docId = formData.get("docId");
  redirect(`/docs/${docId}`);
}

export const metadata = {
  title: "Docs",
};

export default async function DocsPage() {
  const data = await fetch("https://jc5892-340-p2.vercel.app/api/docs", { cache: "no-store" });
  const docs = await data.json();

  return (
    <div className="container mx-auto px-4 py-12 max-w-4xl">
      <section className="text-center mb-12">
        <h1 className="text-3xl md:text-5xl font-bold text-indigo-900 mb-4">
          Documentation
        </h1>
        <p className="text-xl text-indigo-700 max-w-2xl mx-auto">
          A peek into the development of Interstellar Guide
        </p>
      </section>

      <div className="space-y-8">
        {docs.map((entry) => (
          <form
            key={entry.id}
            action={handleDocClick}
            className="bg-blue-100/80 backdrop-blur-md rounded-xl border border-gray-200/50 
              shadow-lg hover:shadow-xl transition-all duration-300 hover:-translate-y-1"
          >
            <input type="hidden" name="docId" value={entry.id} />
            <button
              type="submit"
              className="w-full p-6 text-left focus:outline-none cursor-pointer"
            >
              <h2 className="text-2xl font-semibold text-indigo-900 mb-2">
                {entry.title}
              </h2>
              <p className="text-sm text-indigo-600 mb-4">{entry.date}</p>
              <p className="text-indigo-700 leading-relaxed">{entry.excerpt}</p>
            </button>
          </form>
        ))}
      </div>
    </div>
  );
}