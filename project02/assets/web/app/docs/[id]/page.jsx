import Link from "next/link";
import ReactMarkdown from "react-markdown";

export async function generateMetadata({ params }) {
  const { id } = await params;
  const data = await fetch(`https://jc5892-340-p2.vercel.app/api/docs/${id}`, {
    cache: "no-store",
  });
  const doc = await data.json();
  if (!doc || !doc.id) {
    return {
      title: "Document Not Found",
    };
  }

  return {
    title: doc.title,
  };
}

export default async function DocsDetailPage({ params }) {
  const { id } = await params;
  const data = await fetch(`https://jc5892-340-p2.vercel.app/api/docs/${id}`, {
    cache: "no-store",
  });
  const doc = await data.json();
  if (!doc || !doc.id) {
    return (
      <div className="container mx-auto px-4 py-12 max-w-4xl text-center">
        <h1 className="text-4xl font-bold text-indigo-900 mb-4">Document Not Found</h1>
        <p className="text-indigo-700">Sorry, we couldn't find documentation with ID: {id}</p>
        <Link href="/docs" className="mt-4 inline-block px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300">
          Back to Documentation
        </Link>
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-12 max-w-4xl">
      <section className="mb-12">
        <h1 className="text-3xl md:text-5xl font-bold text-indigo-900 mb-4">
          {doc.title}
        </h1>
        <p className="text-sm text-indigo-600 mb-4">{doc.date}</p>
      </section>

      <article
        className="bg-blue-100/80 backdrop-blur-md rounded-xl p-6 border border-gray-200/50 
          shadow-lg"
      >
        <p className="text-indigo-700 leading-relaxed mb-4">{doc.excerpt}</p>

        <div className="text-indigo-700 prose max-w-none">
          <ReactMarkdown>{doc.content}</ReactMarkdown>
        </div>
      </article>
    </div>
  );
}