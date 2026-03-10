/*
  Warnings:

  - You are about to drop the column `title` on the `Atracao` table. All the data in the column will be lost.
  - Added the required column `nome` to the `Atracao` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Atracao" DROP COLUMN "title",
ADD COLUMN     "nome" TEXT NOT NULL;
