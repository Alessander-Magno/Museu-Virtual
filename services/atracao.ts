import { prisma } from "@/utils/prisma"

export async function mostrarAtracoesSer () {
        const atracoes = await prisma.atracao.findMany();
                        // async e await -> pois fazem uma busca no banco de dados
                        // prisma -> instância do prisma client sendo este quem vai assegurar a conexão com o banco de dados
                        // atracao -> modelo definido no arquivo schema.prisma
                        // const atracoes -> array de objetos
                        // findMany e familia (findUnique, create, update, delete, etc) métodos gerados pelo prisma

        return atracoes
}

export async function criarAtracaoSer ( request: Request ) {
    const body = await request.json();

    const atracaoNova = await prisma.atracao.create({
                        // await prisma.atracao.create -> cria a linha e a envia para ser adicionada ao banco de dados, como esse processo leva tempo ele precisa ser assicrono
        data: {
            title: body.title,
            description: body.description,
            disponibilidade: false // inicialmente todas as atracoes são cadastradas como não disponiveis
        },
    });

    return atracaoNova;
} 