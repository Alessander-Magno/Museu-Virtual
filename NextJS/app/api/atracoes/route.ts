import { criarAtracaoCtrl, mostrarAtracoesCtrl } from "@/controllers/atracao_controller";

// nivel 01
//  GET e POST -> atracoes   

export async function GET () { // me mostre todas as atracoes cadastradas
    return mostrarAtracoesCtrl();
}

export async function POST ( request: Request ) { // cadastra uma nova atracao
                        // request -> pois recebe um body do cliente, ou usuário
    return criarAtracaoCtrl( request );
}