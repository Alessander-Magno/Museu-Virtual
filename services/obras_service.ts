import { prisma } from "@/utils/prisma";

export async function ativarAtracao (id: string, data: any ) {  
    
    if ( data.disponibilidade !== false) {
        throw {
            message: "Estado Inválido"
        }
    }



    return prisma.atracao.update({
        where: { id },
        data: {
            disponibilidade: true
        }
    })
}