export const metadata = {
  title: "Features",
};

const features = [
  {
    title: "Real-Time Updates",
    description: "With updates coming out every 6 weeks, stay updated with the newest characters. Get real-time updates on character stats, abilities, and more.",
    icon: "📊",
  },
  {
    title: "Bookmarking",
    description: "Need to quickly access your favorite character? Introduce bookmarks to your character list. Bookmarking saves your favorite characters in a separate tab for easy access.",
    icon: "🔖",
  },
  {
    title: "Account Creation",
    description: "Create an account to save your favorite characters and settings. *Personalize your cosmic journey with your own account.",
    icon: "👤",
  },
  {
    title: "Cupertino Design",
    description: "Experience a seamless and intuitive interface with our Cupertino design. Navigate through the app effortlessly with a clean and modern look.",
    icon: "🌌",
  },
];

export default function FeaturesPage() {
  return (
    <div className="container mx-auto px-4 py-12 max-w-7xl">
      <div className="text-center mb-12">
        <h1 className="text-3xl md:text-5xl font-bold mb-4">
          App Features
        </h1>
        <p className="text-lg text-indigo-700 max-w-xl mx-auto">
          Discover the powerful features that makes my app your ultimate companion
        </p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        {features.map((feature, index) => (
          <div
            key={index}
            className="group relative bg-blue-100/80 backdrop-blur-md rounded-xl p-6 
            border border-gray-200/50 shadow-lg hover:shadow-xl transition-all duration-300
            hover:-translate-y-1"
          >
            <div className="text-3xl mb-4">{feature.icon}</div>
            <h2 className="text-xl font-semibold text-indigo-900 mb-2">
              {feature.title}
            </h2>
            <p className="text-indigo-700 text-sm leading-relaxed">
              {feature.description}
            </p>
          </div>
        ))}
      </div>
    </div>
  );
}