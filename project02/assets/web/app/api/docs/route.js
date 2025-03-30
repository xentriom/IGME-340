import { NextResponse } from 'next/server';
import { getDocs } from '@/lib/getDocs';

export async function GET() {
  const docs = await getDocs();

  if (docs.message) {
    return NextResponse.json(
      { message: "An error occurred while fetching the documents." },
      { status: 500 }
    );
  }

  return NextResponse.json(docs, { status: 200 });
}