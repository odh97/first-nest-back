/*
  Warnings:

  - You are about to drop the column `conmment` on the `ExpertReview` table. All the data in the column will be lost.
  - Added the required column `comment` to the `ExpertReview` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ExpertReview" DROP COLUMN "conmment",
ADD COLUMN     "comment" TEXT NOT NULL;
