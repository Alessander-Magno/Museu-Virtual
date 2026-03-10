import { criarObraCtrl, mostrarObrasCtrl } from "@/controllers/obra_controller";
import { prisma } from "@/utils/prisma";
import { NextResponse } from "next/server";

// nivel 01
//  GET e POST -> obras  

export async function GET() { // vai buscar todas as obras
  return mostrarObrasCtrl();
}

export async function POST( request: Request ) {
  return criarObraCtrl ( request );
}