-- CreateTable
CREATE TABLE "Atracao" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "disponibilidade" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Atracao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Obra" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "autor" TEXT NOT NULL DEFAULT 'desconhecido',
    "atracaoId" TEXT NOT NULL,

    CONSTRAINT "Obra_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Obra" ADD CONSTRAINT "Obra_atracaoId_fkey" FOREIGN KEY ("atracaoId") REFERENCES "Atracao"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
