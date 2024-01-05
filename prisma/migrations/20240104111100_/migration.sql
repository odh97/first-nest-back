/*
  Warnings:

  - You are about to drop the column `img` on the `ExpertReview` table. All the data in the column will be lost.
  - Added the required column `requestId` to the `ExpertReview` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ExpertReview" DROP COLUMN "img",
ADD COLUMN     "requestId" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "ExpertReview" ADD CONSTRAINT "ExpertReview_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
