import { Geist, Geist_Mono } from "next/font/google";
import { Header } from "@/components/Header";
import { Footer } from "@/components/Footer";
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata = {
  title: {
    default: "Interstellar Guide",
    template: "%s | Interstellar Guide",
  },
  description: "A Honkai: Star Rail companion app for all your needs. Made for IGME 340's project02.",
};

export const viewport = {
  themeColor: "#eef2ff",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased bg-gradient-to-b from-indigo-50 to-indigo-100 flex flex-col min-h-screen`}
      >
        <Header />
        <main className="flex flex-col flex-grow items-center justify-center">{children}</main>
        <Footer />
      </body>
    </html>
  );
}
