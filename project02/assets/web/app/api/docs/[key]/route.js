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

  return NextResponse.json(doc, { status: 200 });
}