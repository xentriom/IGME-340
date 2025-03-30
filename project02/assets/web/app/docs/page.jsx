export const metadata = {
  title: "Docs",
};

export default async function DocsPage() {
  const data = await fetch("https://jc5892-340-p2.vercel.app/api/docs", {
    cache: "no-store",
  });
  const docs = await data.json();

  return (
    <div className="container mx-auto px-4 py-12 max-w-4xl">
      <section className="text-center mb-12">
        <h1 className="text-2xl md:text-5xl font-bold text-indigo-900 mb-4">
          Documentation
        </h1>
        <p className="text-xl text-indigo-700 max-w-2xl mx-auto">
          A peak into the development of Interstellar Guide
        </p>
      </section>

      <div className="space-y-8">
        {docs.map((entry) => (
          <article
            key={entry.id}
            className="bg-blue-100/80 backdrop-blur-md rounded-xl p-6 border border-gray-200/50 
              shadow-lg hover:shadow-xl transition-all duration-300 hover:-translate-y-1"
          >
            <h2 className="text-2xl font-semibold text-indigo-900 mb-2">
              {entry.title}
            </h2>
            <p className="text-sm text-indigo-600 mb-4">{entry.date}</p>
            <p className="text-indigo-700 leading-relaxed">
              {entry.excerpt}
            </p>
          </article>
        ))}
      </div>
    </div>
  );
}