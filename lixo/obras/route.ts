import { prisma } from "@/utils/prisma";
import { NextResponse } from "next/server";

// nivel 03
//  GET e POST -> obras  

export async function GET( _request: Request, { params }: { params: { id: string } }) { // vai buscar as obras vinculadas ao id da atracao
  try {
    const obras = await prisma.obra.findMany({
      where: { atracaoId: params.id },
    });

    return NextResponse.json( obras );
  } catch ( error ) {
    return NextResponse.json(
      { error: "Erro ao buscar obras" },
      { status: 500 }
    );
  }
}

export async function POST( request: Request, { params }: { params: { id: string } }) {
  try {
    const body = await request.json();

    // Certifica que a atração existe antes de vincular a obra
    const atracao = await prisma.atracao.findUnique({
      where: { id: params.id },
    });

    if ( !atracao ) {
      return NextResponse.json(
        { error: "Atração não encontrada" },
        { status: 404 }
      );
    }

    const obra = await prisma.obra.create({
      data: {
        title: body.title,
        description: body.description,
        autor: body.autor ?? "desconhecido",
        atracaoId: params.id,
      },
    });

    return NextResponse.json( obra, { status: 201 } );
  } catch ( error ) {
    return NextResponse.json(
      { error: "Erro ao cadastrar obra" },
      { status: 400 }
    );
  }
}