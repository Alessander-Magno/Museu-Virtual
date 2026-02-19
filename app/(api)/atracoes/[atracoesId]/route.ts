import { prisma } from "@/utils/prisma"
import { NextResponse } from "next/server";

// nivel 02
//  GET, PUT e DELETE -> atracoes   

interface Params { // contrato
  params: Promise<{
    atracoesId: string;
  }>;
}

export async function GET( _request: Request, { params }: Params ) { // busca uma atracao em especifico e suas obras
                        // _request -> pois não é utilizado, serve apenas para evitar warnings advindos do uso do params
                        // params -> usado em rotas dinamicas
  try {
    const { atracoesId } = await params;

    const atracao = await prisma.atracao.findUnique({
      where: { id: atracoesId, }, // ids correspondentes
      // include: { obras: true, }, // inclua as obras desta atracao
    });

    if ( !atracao ) { // erro de id
      return NextResponse.json(
        { error: "Atração não encontrada" },
        { status: 404 }
      );
    }

    return NextResponse.json( atracao );
  } catch ( error ) {
    return NextResponse.json(
      { error: "Erro ao buscar atração" },
      { status: 500 }
    );
  }
}

export async function PATCH( request: Request, { params }: Params ) { // alterar dados
  try {
    const body = await request.json();
    const { atracoesId } = await params;
    
    const existe = await prisma.atracao.findUnique({
      where: { id: atracoesId }
    })

    if ( !existe ) {
      return NextResponse.json(
        { "message": "Id inválido"}
      )
    }

    const atracao = await prisma.atracao.update({
      where: { id: atracoesId, },
      data: {
        title: body.title,
        description: body.description
      },
    });

    return NextResponse.json(atracao);
  } catch (error) {
    return NextResponse.json(
      { error: "Erro ao atualizar os dados da atração" },
      { status: 400 }
    );
  }
}

export async function DELETE( _request: Request, { params }: Params ) { // deletar atracao
  try {
    const { atracoesId } = await params; 

    const existe = await prisma.atracao.findUnique({
      where: { id: atracoesId }
    })

    if ( !existe ) {
      return NextResponse.json(
        {"message": "Id inválido"}
      )
    }

    const qtdObras = await prisma.obra.count({
      where: { atracaoId: atracoesId }
    })

    if ( qtdObras !== 0 ) {
      return NextResponse.json({
        message: "Não é possivel realizar essa operação, pois há obras vinculadas a essa atração"
      })
    }

    await prisma.atracao.delete({ // remoção da atração
      where: { id: atracoesId, },
    });

    return NextResponse.json(
      { message: "Atração removida com sucesso" },
      { status: 200 }
    );
  } catch (error) {
    return NextResponse.json(
      { error: "Erro ao deletar atração" },
      { status: 400 }
    );
  }
}