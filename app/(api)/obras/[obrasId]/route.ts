import { prisma } from "@/utils/prisma";
import { NextResponse } from "next/server";

// nivel 04
//  GET, PUT e DELETE -> obras 

interface Params {
  params: Promise<{
    obrasId: string
  }>;
}

export async function GET( _request: Request, { params }: Params ) { // busca por uma obra em especifico
  try {
    const { obrasId } = await params;
    
    const obra = await prisma.obra.findUnique({
      where: { id: obrasId },
    });

    if ( !obra ) {
      return NextResponse.json(
        { error: "Obra não encontrada" },
        { status: 404 }
      );
    }

    return NextResponse.json( obra );
  } catch ( error ) {
    return NextResponse.json(
      { error: "Erro ao buscar obra" },
      { status: 500 }
    );
  }
}

export async function PATCH( request: Request, { params }: Params ) { // atualizar dados
  try {
    const body = await request.json();
    const { obrasId } = await params;

    const existe = await prisma.obra.findUnique({ // busca pelo id da obra
      where: { id: obrasId }
    })

    if ( !existe ) { // verifica se existe alguma obra com esse id
      return NextResponse.json(
        { message : "Obra não encontrada" }
      );
    }

    const obra = await prisma.obra.update({
      where: { id: obrasId },
      data: {
        title: body.title,
        description: body.description,
        autor: body.autor,
      },
    });

    return NextResponse.json( obra );
  } catch ( error ) {
    return NextResponse.json(
      { error: "Erro ao atualizar obra" },
      { status: 400 }
    );
  }
}

export async function DELETE( _request: Request, { params }: Params ) { // remoção de obra
  try {
    const { obrasId } = await params;

    const existe = await prisma.obra.findUnique({ // busca pelo id da obra
      where: { id: obrasId }
    })

    if ( !existe ) { // verifica se existe alguma obra com esse id
      return NextResponse.json(
        { message : "Obra não encontrada" }
      );
    }

    await prisma.obra.delete({ // deleta a obra
      where: { id: obrasId },
    });

    const qtdObras = await prisma.obra.count({
      where: { atracaoId: existe.atracaoId }
    })

    if ( qtdObras === 0 ) { // indisponibiliza a atracao caso não tenha mais obras
      await prisma.atracao.update({
        where: { id: existe.atracaoId},
        data: {
          disponibilidade: false
        }
      })
    }

    return NextResponse.json({ message: "Obra removida com sucesso" });
  } catch ( error ) {
    return NextResponse.json(
      { error: "Erro ao remover obra" },
      { status: 400 }
    );
  }
}