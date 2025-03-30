import { NextResponse } from 'next/server';
import { getDocs } from '@/lib/getDocs';

export async function GET(request, { params }) {
  const { key } = await params;
  const docs = await getDocs();

  if (docs.message) {
    return NextResponse.json(
      { message: "An error occurred while fetching the documents." },
      { status: 500 }
    );
  }

  const doc = docs.find((doc) => doc.key === key);
  if (!doc) {
    return NextResponse.json(
      { message: "Document not found." },
      { status: 404 }
    );
  }

  const total = docs.length;
  const currentIndex = docs.findIndex((d) => d.key === key);
  const prevKey = currentIndex === 0 ? docs[total - 1].key : docs[currentIndex - 1].key;
  const nextKey = currentIndex === total - 1 ? docs[0].key : docs[currentIndex + 1].key;

  const response = {
    total,
    prevKey,
    nextKey,
    ...doc,
  };
  console.log(response);

  return NextResponse.json(response, { status: 200 });
}