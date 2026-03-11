import { mostrarObraCtrl, alterarInfoObraCtrl, deletarObraCtrl } from "@/controllers/obra_controller";
import { prisma } from "@/utils/prisma";
import { NextResponse } from "next/server";

// nivel 02
//  GET, PUT e DELETE -> obras 

interface Params {
  params: Promise<{
    obraId: string
  }>;
}

export async function GET( request: Request, Params: Params ) { // busca por uma obra em especifico
  return mostrarObraCtrl( Params );
}

export async function PATCH( request: Request, Params: Params ) { // atualizar dados
  return alterarInfoObraCtrl( request, Params );
}

export async function DELETE( request: Request, Params: Params ) { // remoção de obra
  return deletarObraCtrl( Params );
}
