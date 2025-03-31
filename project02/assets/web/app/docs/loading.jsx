export default function Loading() {
  return (
    <div className="container mx-auto px-4 py-12 max-w-3xl">
      <section className="text-center mb-12">
        <div className="h-10 md:h-12 w-3/4 mx-auto bg-gray-200 rounded animate-pulse mb-4"></div>
        <div className="h-5 w-1/2 mx-auto bg-gray-200 rounded animate-pulse"></div>
      </section>

      <div className="space-y-8">
        {Array.from({ length: 3 }).map((_, index) => (
          <div
            key={index}
            className="bg-blue-100/80 backdrop-blur-md rounded-xl border border-gray-200/50 
            shadow-lg p-6 animate-pulse"
          >
            <div className="h-6 w-2/3 bg-gray-200 rounded mb-2"></div>
            <div className="h-4 w-1/4 bg-gray-200 rounded mb-4"></div>
            <div className="space-y-2">
              <div className="h-4 w-full bg-gray-200 rounded"></div>
              <div className="h-4 w-5/6 bg-gray-200 rounded"></div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}