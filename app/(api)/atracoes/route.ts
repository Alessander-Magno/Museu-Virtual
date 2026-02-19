import { prisma } from "@/utils/prisma"
import { NextResponse } from "next/server";

// nivel 01
//  GET e POST -> atracoes   

export async function GET () { // me mostre todas as atracoes cadastradas
    try {
        const atracoes = await prisma.atracao.findMany();
                        // async e await -> pois fazem uma busca no banco de dados
                        // prisma -> instância do prisma client sendo este quem vai assegurar a conexão com o banco de dados
                        // atracao -> modelo definido no arquivo schema.prisma
                        // const atracoes -> array de objetos
                        // findMany e familia (findUnique, create, update, delete, etc) métodos gerados pelo prisma

        if ( atracoes.length === 0 ) {
            return NextResponse.json(
                {"message": "Nenhuma atração cadastrada"}
            )
        }

        return NextResponse.json( atracoes ); 
                        // json() -> converte para esse formato
                        // NextResponse -> resposta a uma requisição http
    } catch ( error ) {
        return NextResponse.json(
            { error: "Erro ao buscar atração" },
            { status: 500  }
        );
    }
}

export async function POST ( request: Request ) { // cadastra uma nova atracao
                        // request -> pois recebe um body do cliente, ou usuário

    try {
        const body = await request.json();

        const atracoes = await prisma.atracao.create({
                        // await prisma.atracao.create -> cria a linha e a envia para ser adicionada ao banco de dados, como esse processo leva tempo ele precisa ser assicrono
            data: {
                title: body.title,
                description: body.description,
                disponibilidade: false // inicialmente todas as atracoes são cadastradas como não disponiveis
            },
        });

        return NextResponse.json( atracoes, {status: 201} );
    } catch ( error ) {
        return NextResponse.json(
            { error: "Erro ao adicionar atração" },
            { status: 400 }
        );
    }
}