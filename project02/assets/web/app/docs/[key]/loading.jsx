export default function Loading() {
  return (
    <div className="container mx-auto px-4 py-12 max-w-4xl">
      <section className="mb-6">
        <div className="h-10 md:h-12 w-3/4 bg-gray-200 rounded animate-pulse mb-4"></div>
        <div className="h-4 w-1/4 bg-gray-200 rounded animate-pulse mb-4"></div>
        <div className="h-5 w-5/6 bg-gray-200 rounded animate-pulse"></div>
      </section>

      <article
        className="bg-blue-100/80 backdrop-blur-md rounded-xl p-6 border border-gray-200/50 
          shadow-lg mb-6"
      >
        <div className="space-y-4 animate-pulse">
          <div className="h-6 w-2/3 bg-gray-200 rounded"></div>
          <div className="h-4 w-full bg-gray-200 rounded"></div>
          <div className="h-4 w-5/6 bg-gray-200 rounded"></div>
          <div className="h-64 w-full max-w-md mx-auto bg-gray-200 rounded-lg my-4"></div>
          <div className="h-4 w-4/5 bg-gray-200 rounded"></div>
          <div className="h-4 w-3/4 bg-gray-200 rounded"></div>
        </div>
      </article>

      <nav className="flex justify-center items-center gap-4 text-sm">
        <div className="h-10 w-20 bg-gray-200 rounded-lg animate-pulse"></div>
        <div className="h-4 w-24 bg-gray-200 rounded animate-pulse"></div>
        <div className="h-10 w-20 bg-gray-200 rounded-lg animate-pulse"></div>
      </nav>
    </div>
  );
}