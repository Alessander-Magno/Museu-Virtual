import { NextResponse } from "next/server";
import { alterarInfoAtracaoSer, criarAtracaoSer, deletarAtracaoSer, mostrarAtracaoSer, mostrarAtracoesSer } from "@/services/atracao_service";

interface Params {
  params: Promise<{
    atracaoId: string,
  }>;
}

export async function mostrarAtracoesCtrl () {
    try {
        const atracoes = await mostrarAtracoesSer();
        
        return NextResponse.json( atracoes ); 
                        // json() -> converte para esse formato
                        // NextResponse -> resposta a uma requisição http
    } catch ( error: any ) {
        console.error( error )

        return NextResponse.json(
            { error: error?.message || "Erro ao buscar atrações" },
            { status: error?.statusCode || 500 }
        );
    }
}

export async function mostrarAtracaoCtrl ( { params }: Params ) {
    try {
        const { atracaoId } = await params;

        const atracao = await mostrarAtracaoSer( atracaoId );
        
        return NextResponse.json( atracao ); 
                       
    } catch ( error: any ) { // o throw dispara o catch

        // if (error?.message && error?.status) { // erro esperado = ( mensagem + status )
        //     return NextResponse.json(
        //         { error: error.status},
        //         { status: error.status}
        //     )
        // }

        console.error( error ) // erro no processo

        return NextResponse.json( // erro no processo
            { error: error?.message || 'Erro ao buscar atração'},
            { status: error?.statusCode || 500 }
        );
    }
}

export async function criarAtracaoCtrl ( request: Request ) {
    try {
        const body = await request.json();

        const {nome, description} = body;
        
        const atracaoNova = await criarAtracaoSer( nome, description );
    
        return NextResponse.json( atracaoNova, {status: 201} );
    } catch ( error: any ) {
        console.error( error );

        return NextResponse.json(
            { error: error?.message || "Erro ao adicionar atração" },
            { status: error?.statusCode || 500 }
        );
    }
}

export async function alterarInfoAtracaoCtrl ( request: Request, { params }: Params ) {
    try {
        const { atracaoId } = await params;

        const body = await request.json();

        const atracaoAlterada = await alterarInfoAtracaoSer( atracaoId, body );

        return NextResponse.json( atracaoAlterada );
    } catch ( error: any ) {
        console.error( error );

        return NextResponse.json(
            { error: error?.message || "Erro ao atualizar os dados da atração" },
            { status: error?.statusCode || 404 }
        );
    }
}

export async function deletarAtracaoCtrl ( { params }: Params ) {
    try {
        const { atracaoId } = await params;

        await deletarAtracaoSer( atracaoId );

        return NextResponse.json(
            { message: "Remoção concluida" },
        )
    } catch ( error: any ) {
        console.error( error );

        return NextResponse.json(
            { error: error?.message || 'Erro ao remover atração' },
            { status: error?.statusCode || 500 }
        );
    }
}
    