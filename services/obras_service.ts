import { prisma } from "@/utils/prisma";

export async function ativarAtracao (id: string, data: any ) {  
    
    if ( data.disponibilidade !== false) {
        throw {
            message: "Estado Inválido"
        }
    }

    /*
    const obrasCount = await prisma.obra.count({ // quantas obras estão vinculadas ao id da atracao que foi passado
        where: { atracaoId: id }
    })

    if ( obrasCount === 0 ) {
        throw {
            message: ""
        }
    }
    */

    return prisma.atracao.update({
        where: { id },
        data: {
            disponibilidade: true
        }
    })
}