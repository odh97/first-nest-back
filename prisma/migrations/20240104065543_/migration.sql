/*
  Warnings:

  - You are about to drop the column `requestId` on the `ExpertReview` table. All the data in the column will be lost.
  - Made the column `company` on table `Expert` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `img` to the `ExpertReview` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Expert" ALTER COLUMN "company" SET NOT NULL,
ALTER COLUMN "company" SET DEFAULT '기본사무소',
ALTER COLUMN "icon" SET DEFAULT '안녕',
ALTER COLUMN "description" SET DEFAULT '안녕하세요';

-- AlterTable
ALTER TABLE "ExpertReview" DROP COLUMN "requestId",
ADD COLUMN     "img" TEXT NOT NULL;
