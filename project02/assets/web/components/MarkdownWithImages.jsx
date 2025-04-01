import Image from "next/image";
import ReactMarkdown from "react-markdown";
import rehypeRaw from "rehype-raw";

export function MarkdownWithImages({ content, images }) {
  function ImageRenderer({ src, alt, ...props }) {
    const imageData = props["data-key"]
      ? images.find((img) => img.key === props["data-key"])
      : { src, alt };
    return (
      <Image
        src={imageData.src}
        alt={imageData.alt}
        width={imageData.width || 200}
        height={imageData.height || 600}
        className="max-w-full h-auto rounded-lg mx-auto block my-4"
      />
    );
  }

  const components = {
    img: ImageRenderer,
    h3: ({ children }) => (
      <h3 className="text-indigo-800 text-lg font-bold mb-1">{children}</h3>
    ),
    p: ({ children }) => (
      <p className="leading-relaxed">{children}</p>
    ),
    ul: ({ children }) => (
      <ul className="list-disc list-inside">{children}</ul>
    ),
    ol: ({ children }) => (
      <ol className="list-decimal list-inside">{children}</ol>
    ),
    li: ({ children }) => (
      <li className="ml-4">{children}</li>
    ),
    a: ({ href, children }) => (
      <a
        href={href}
        className="hover:text-blue-500 underline transition-colors duration-200"
        target="_blank"
        rel="noopener noreferrer"
      >
        {children}
      </a>
    ),
    strong: ({ children }) => (
      <strong className="font-bold">{children}</strong>
    ),
    code: ({ children }) => (
      <code className="bg-indigo-200 text-zinc-950 px-1 py-0.5 rounded text-sm">{children}</code>
    ),
    pre: ({ children }) => (
      <pre className="bg-indigo-200 text-zinc-950 p-4 rounded text-sm overflow-x-auto">
        {children}
      </pre>
    ),
  };

  return (
    <ReactMarkdown
      rehypePlugins={[rehypeRaw]}
      components={components}
    >
      {content}
    </ReactMarkdown>
  );
}