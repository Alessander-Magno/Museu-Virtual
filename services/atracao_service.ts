import { PacoteErro } from "@/modulos/pacote_erro";
import { prisma } from "@/utils/prisma"

export async function mostrarAtracoesSer () {
        const atracoes = await prisma.atracao.findMany();
                        // async e await -> pois fazem uma busca no banco de dados
                        // prisma -> instância do prisma client sendo este quem vai assegurar a conexão com o banco de dados
                        // atracao -> modelo definido no arquivo schema.prisma
                        // const atracoes -> array de objetos
                        // findMany e familia (findUnique, create, update, delete, etc) métodos gerados pelo prisma

        if (atracoes.length === 0) {
            throw new PacoteErro("Nenhuma atração cadastrada", 200);
        }

        return atracoes
}

export async function mostrarAtracaoSer ( atracaoId: string ) {
    const atracao = await prisma.atracao.findUnique({
      where: { id: atracaoId, }, // ids correspondentes
      // include: { obras: true, }, // inclua as obras desta atracao
    });

    if ( !atracao ) { // erro de id
        throw new PacoteErro("Atração não encontrada", 404);
    }
         
    return atracao;
}

export async function criarAtracaoSer ( nome: string, description: string ) {

    const atracaoNova = await prisma.atracao.create({
                        // await prisma.atracao.create -> cria o objeto e a envia para ser adicionada ao banco de dados, como esse processo leva tempo ele precisa ser assicrono
        data: {
            nome: nome,
            description: description,
            disponibilidade: false // inicialmente todas as atracoes são cadastradas como não disponiveis
        },
    });

    if ( !atracaoNova ) {
      throw new PacoteErro("Falha na criação", 500);
    }

    return atracaoNova;
} 

export async function alterarInfoAtracaoSer ( atracaoId: string, body: any) { 
    const existe = await prisma.atracao.findUnique({
        where: { id: atracaoId }
    })

    if ( !existe ) {
      throw new PacoteErro("Atração não encontrada", 404);
    }

    const atracaoAlterada = await prisma.atracao.update({
      where: { id: atracaoId, },
      data: {
        nome: body.nome,
        description: body.description
      },
    });

    if ( !atracaoAlterada ) {
      throw new PacoteErro("Falha na alteração", 500);
    }

    return atracaoAlterada;
}

export async function deletarAtracaoSer ( atracaoId: string ) {
    
    const atracao = await prisma.atracao.findUnique({
      where: { id: atracaoId }
    })

    if ( !atracao ) {
        throw new PacoteErro("Atração não encontrada", 404);
    }

    const qtdObras = await prisma.obra.count({
      where: { atracaoId: atracaoId }
    })

    if ( qtdObras !== 0 ) {
        throw new PacoteErro("Não é possivel remover uma atração com obras vinculadas", 409);
    }

    await prisma.atracao.delete({ // remoção da atração
      where: { id: atracaoId, },
    });
}
