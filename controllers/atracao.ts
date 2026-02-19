import { NextResponse } from "next/server";
import { criarAtracaoSer, mostrarAtracoesSer } from "@/services/atracao"

export async function mostrarAtracoesCtrl () {
    try {
        const atracoes = mostrarAtracoesSer();
        
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

export async function criarAtracaoCtrl ( request: Request) {
    try {
        const atracaoNova = criarAtracaoSer( request );
    
        return NextResponse.json( atracaoNova, {status: 201} );
    } catch ( error ) {
        return NextResponse.json(
            { error: "Erro ao adicionar atração" },
            { status: 400 }
        );
    }
}