import { PacoteErro } from "@/modulos/pacote_erro";
import { prisma } from "@/utils/prisma"

export async function mostrarObrasSer () {
        const obras = await prisma.obra.findMany();
                        // async e await -> pois fazem uma busca no banco de dados
                        // prisma -> instância do prisma client sendo este quem vai assegurar a conexão com o banco de dados
                        // atracao -> modelo definido no arquivo schema.prisma
                        // const atracoes -> array de objetos
                        // findMany e familia (findUnique, create, update, delete, etc) métodos gerados pelo prisma

        // if (obras.length === 0) {
        //     throw new PacoteErro("Nenhuma obra cadastrada", 200);
        // }

        return obras
}

export async function mostrarObraSer ( obraId: string ) {
    const obra = await prisma.obra.findUnique({
      where: { id: obraId, },
    });

    if ( !obra ) { // erro de id
        throw new PacoteErro("Obra não encontrada", 404);
    }
         
    return obra;
}

export async function criarObraSer ( title: string, description: string, autor: string, atracaoId: string ) {
    // Certifica que a atração existe antes de vincular a obra
    const atracaoChecagem = await prisma.atracao.findUnique({
      where: { id: atracaoId, }, 
    });

    if ( !atracaoChecagem ) { 
        throw new PacoteErro("Atração não encontrada: id não corresponde a nenhuma atração cadastrada", 404);
    }
    
    const obraNova = await prisma.obra.create({
        data: {
            title: title,
            description: description,
            autor: autor,
            atracaoId: atracaoId
        },
    });

    if ( !obraNova ) {
      throw new PacoteErro("Falha na criação", 500);
    }

    const qtdObras = await prisma.obra.count({
      where: { atracaoId: atracaoId }
    })

    if ( qtdObras === 1 ) { // caso for a primeira obra a ser cadastrada na atração, esta passará a ficar disponivel
      const disponivel = await prisma.atracao.update({
        where: { id: atracaoId },
        data: {
          disponibilidade: true
        }
      });

      if ( !disponivel ) {
        throw new PacoteErro("Obra cadastrada, mas houve erro na alteração de estado da atração", 500);
        }
    }

    return obraNova;
} 

export async function alterarInfoObraSer ( obraId: string, title: string, description: string, autor: string) { 
    const existe = await prisma.obra.findUnique({
        where: { id: obraId }
    })

    if ( !existe ) {
      throw new PacoteErro("Obra não encontrada", 404);
    }

    const obraAlterada = await prisma.obra.update({
      where: { id: obraId, },
      data: {
        title: title,
        description: description,
        autor: autor
      },
    });

    if ( !obraAlterada ) {
      throw new PacoteErro("Falha na alteração", 500);
    }

    return obraAlterada;
}

export async function deletarObraSer ( obraId: string ) {
    
    const obra = await prisma.obra.findUnique({
      where: { id: obraId }
    })

    if ( !obra ) {
        throw new PacoteErro("Obra não encontrada", 404);
    }

    const atracaoId = obra.atracaoId; // o objeto obra será removido

    await prisma.obra.delete({ // deleta a obra
      where: { id: obraId },
    });

    const qtdObras = await prisma.obra.count({
      where: { atracaoId: atracaoId } // quantas obras estão vinculadas a essa foreign key
    }) // se a obra existe, logo ela está vinculada a uma atração

    if ( qtdObras === 0 ) { // indisponibiliza a atracao caso não tenha mais obras
      await prisma.atracao.update({
        where: { id: atracaoId},
        data: {
          disponibilidade: false
        }
      })
    }
}
