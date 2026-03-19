import { alterarInfoAtracaoCtrl, deletarAtracaoCtrl, mostrarAtracaoCtrl, mostrarAtracoesCtrl } from "@/controllers/atracao_controller";

// nivel 02
//  GET, PUT e DELETE -> atracoes  

interface Params {
  params: Promise<{
    atracaoId: string,
  }>;
}

export async function GET( request: Request, Params: Params ) { // busca uma atracao em especifico e suas obras
                        // _request -> pois não é utilizado, serve apenas para evitar warnings advindos do uso do params
                        // params -> usado em rotas dinamicas

  return mostrarAtracaoCtrl( Params );  
}

export async function PATCH( request: Request, Params: Params ) { // alterar dados
 return alterarInfoAtracaoCtrl ( request, Params );
}

export async function DELETE( request: Request, Params: Params ) { // deletar atracao
  
  return deletarAtracaoCtrl ( Params );
}