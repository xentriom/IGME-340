import Link from "next/link";
import { MarkdownWithImages } from "@/components/MarkdownWithImages";

function replaceImagePlaceholders(content, images = []) {
  let updatedContent = content;
  images.forEach((image) => {
    const placeholder = `{{${image.key}}}`;
    const imgTag = `<img src="${image.src}" alt="${image.alt}" data-key="${image.key}" />`;
    updatedContent = updatedContent.replace(placeholder, imgTag);
  });
  return updatedContent;
}

export async function generateMetadata({ params }) {
  const { key } = await params;
  const apiUrl =
    process.env.NODE_ENV === "development"
      ? `http://localhost:3000/api/docs/${key}`
      : `https://jc5892-340-p2.vercel.app/api/docs/${key}`;
  const data = await fetch(apiUrl, { cache: "no-store" });
  const doc = await data.json();
  if (!doc || !doc.key) {
    return {
      title: "Document Not Found",
    };
  }

  return {
    title: doc.title,
  };
}

export default async function DocsDetailPage({ params }) {
  const { key } = await params;
  const apiUrl =
    process.env.NODE_ENV === "development"
      ? `http://localhost:3000/api/docs/${key}`
      : `https://jc5892-340-p2.vercel.app/api/docs/${key}`;
  const data = await fetch(apiUrl, { cache: "no-store" });
  const doc = await data.json();
  if (!doc || !doc.key) {
    return (
      <div className="container mx-auto px-4 py-12 max-w-4xl text-center">
        <h1 className="text-4xl font-bold text-indigo-900 mb-4">Document Not Found</h1>
        <p className="text-indigo-700">Sorry, we couldn't find documentation with key: {key}</p>
        <Link href="/docs" className="mt-4 inline-block px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300">
          Back to Documentation
        </Link>
      </div>
    );
  }

  const processedContent = replaceImagePlaceholders(doc.content, doc.images);

  return (
    <div className="container mx-auto px-4 py-12 max-w-4xl">
      <section className="mb-6">
        <h1 className="text-3xl md:text-5xl font-bold text-indigo-900 mb-4">
          {doc.title}
        </h1>
        <p className="text-sm text-indigo-600 mb-4">{doc.date}</p>
        <p className="text-indigo-700 leading-relaxed mb-4">{doc.excerpt}</p>
      </section>

      <article
        className="bg-blue-100/80 backdrop-blur-md rounded-xl p-6 border border-gray-200/50 
          shadow-lg mb-6"
      >
        <div className="text-indigo-700 max-w-none flex flex-col gap-4">
          <MarkdownWithImages content={processedContent} images={doc.images} />
        </div>
      </article>

      <nav className="flex justify-center items-center gap-4 text-sm">
        <Link
          href={`/docs/${doc.prevKey}`}
          className="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300"
        >
          Previous
        </Link>
        <span className="text-indigo-700">
          Entry {doc.id} of {doc.total}
        </span>
        <Link
          href={`/docs/${doc.nextKey}`}
          className="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-blue-500 transition-colors duration-300"
        >
          Next
        </Link>
      </nav>
    </div>
  );
}