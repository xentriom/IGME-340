import fs from "fs";
import path from "path";

const docsFilePath = path.join(process.cwd(), "lib", "docs.json");

export async function getDocs() {
  try {
    const data = await fs.promises.readFile(docsFilePath, "utf-8");
    return JSON.parse(data);
  } catch (error) {
    return { message: "Error reading docs file" };
  }
}