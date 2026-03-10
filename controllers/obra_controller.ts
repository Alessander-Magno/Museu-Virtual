import { NextResponse } from "next/server";
import { mostrarObrasSer, criarObraSer, mostrarObraSer, alterarInfoObraSer, deletarObraSer } from "@/services/obra_service";

interface Params {
  params: Promise<{
    obraId: string,
  }>;
}

export async function mostrarObrasCtrl () {
    try {
        const obras = await mostrarObrasSer();
        
        return NextResponse.json( obras ); 
                        // json() -> converte para esse formato
                        // NextResponse -> resposta a uma requisição http
    } catch ( error: any ) {
        console.error( error )

        return NextResponse.json(
            { error: error?.message || "Erro ao buscar obras" },
            { status: error?.statusCode || 500 }
        );
    }
}

export async function mostrarObraCtrl ( { params }: Params ) {
    try {
        const { obraId } = await params;

        const obra = await mostrarObraSer( obraId );
        
        return NextResponse.json( obra ); 
                       
    } catch ( error: any ) { // o throw dispara o catch

        // if (error?.message && error?.status) { // erro esperado = ( mensagem + status )
        //     return NextResponse.json(
        //         { error: error.status},
        //         { status: error.status}
        //     )
        // }

        console.error( error ) // erro no processo

        return NextResponse.json( // erro no processo
            { error: error?.message || 'Erro ao buscar obra'},
            { status: error?.statusCode || 500 }
        );
    }
}

export async function criarObraCtrl ( request: Request ) {
    try {
        const body = await request.json();

        const { title, description, autor = 'desconhecido', atracaoId } = body;
        
        const obraNova = await criarObraSer( title, description, autor, atracaoId );
    
        return NextResponse.json( obraNova, {status: 201} );
    } catch ( error: any ) {
        console.error( error );

        return NextResponse.json(
            { error: error?.message || "Erro ao criar obra" },
            { status: error?.statusCode || 500 }
        );
    }
}

export async function alterarInfoObraCtrl ( request: Request, { params }: Params ) {
    try {
        const { obraId } = await params;

        const body = await request.json();

        const { title, description, autor } = body;

        const obraAlterada = await alterarInfoObraSer( obraId, title, description, autor );

        return NextResponse.json( obraAlterada );
    } catch ( error: any ) {
        console.error( error );

        return NextResponse.json(
            { error: error?.message || "Erro ao atualizar os dados da obra" },
            { status: error?.statusCode || 404 }
        );
    }
}

export async function deletarObraCtrl ( { params }: Params ) {
    try {
        const { obraId } = await params;

        await deletarObraSer( obraId );

        return NextResponse.json(
            { message: "Remoção concluida" },
        )
    } catch ( error: any ) {
        console.error( error );

        return NextResponse.json(
            { error: error?.message || 'Erro ao remover obra' },
            { status: error?.statusCode || 500 }
        );
    }
}
    