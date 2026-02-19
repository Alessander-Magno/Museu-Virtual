import { prisma } from "@/utils/prisma";
import { NextResponse } from "next/server";

// nivel 03
//  GET e POST -> obras  

export async function GET() { // vai buscar todas as obras
  try {
    const obras = await prisma.obra.findMany();

    if ( obras.length === 0) {
      return NextResponse.json(
        { "message": "Nenhuma obra cadastrada" }
      )
    }

    return NextResponse.json( obras );
  } catch ( error ) {
    return NextResponse.json(
      { error: "Erro ao buscar obras" },
      { status: 500 }
    );
  }
}

export async function POST( request: Request ) {
  try {
    const body = await request.json();

    // Certifica que a atração existe antes de vincular a obra
    const existe = await prisma.atracao.findUnique({
      where: { id: body.atracaoId },
    });

    if ( !existe ) {
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
        atracaoId: body.atracaoId,
      },
    });

    const qtdObras = await prisma.obra.count({
      where: { atracaoId: body.atracaoId }
    })

    if ( qtdObras === 1 ) { // caso for a primeira obra a ser cadastrada na atração, esta passará a ficar disponivel
      const disponivel = await prisma.atracao.update({
        where: { id: body.atracaoId },
        data: {
          disponibilidade: true
        }
      })
    }

    return NextResponse.json( obra, { status: 201 } );
  } catch ( error ) {
    return NextResponse.json(
      { error: "Erro ao cadastrar obra" },
      { status: 400 }
    );
  }
}