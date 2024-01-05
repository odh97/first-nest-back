/*
  Warnings:

  - You are about to drop the `Bookmark` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "CrawlingState" AS ENUM ('READY', 'SUCCESS', 'FAIL');

-- CreateEnum
CREATE TYPE "AuthType" AS ENUM ('LOCAL', 'OAUTH', 'TEMP');

-- CreateEnum
CREATE TYPE "TestType" AS ENUM ('Finance', 'Romance', 'Crypto');

-- CreateEnum
CREATE TYPE "AuthCodeType" AS ENUM ('EMAIL', 'PHONE');

-- CreateEnum
CREATE TYPE "RequestState" AS ENUM ('REQUESTED', 'ACCEPTED', 'REJECTED', 'CANCELED', 'FINISHED');

-- CreateEnum
CREATE TYPE "ReportType" AS ENUM ('ScamPostComment', 'ScamDictionaryComment', 'Review');

-- CreateEnum
CREATE TYPE "Provider" AS ENUM ('GOOGLE', 'APPLE', 'EMAIL', 'NAVER', 'KAKAO');

-- CreateEnum
CREATE TYPE "MsgType" AS ENUM ('TEXT', 'IMAGE', 'VIDEO', 'FILE', 'REQUEST');

-- DropTable
DROP TABLE "Bookmark";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "Accounts" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "type" "AuthType" NOT NULL DEFAULT 'LOCAL',
    "provider" "Provider" NOT NULL DEFAULT 'EMAIL',
    "providerAccountId" TEXT DEFAULT '',
    "expiredAt" TIMESTAMP(3),
    "password" TEXT DEFAULT '',
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Accounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Users" (
    "id" TEXT NOT NULL,
    "email" TEXT,
    "name" TEXT,
    "phone" TEXT,
    "isExpert" BOOLEAN NOT NULL DEFAULT false,
    "isDelete" BOOLEAN NOT NULL DEFAULT false,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleteAt" TIMESTAMP(3),
    "icon" TEXT,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserAccessTokens" (
    "index" SERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "platform" TEXT NOT NULL,
    "access" TEXT NOT NULL,
    "refresh" TEXT NOT NULL,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserAccessTokens_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "AuthCode" (
    "index" SERIAL NOT NULL,
    "type" "AuthCodeType" NOT NULL,
    "code" TEXT NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "key" TEXT NOT NULL,

    CONSTRAINT "AuthCode_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "UserChatList" (
    "index" SERIAL NOT NULL,
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expertId" TEXT NOT NULL,
    "requestId" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserChatList_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "UserRequests" (
    "index" SERIAL NOT NULL,
    "id" TEXT NOT NULL,
    "chatId" TEXT NOT NULL,
    "expertId" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "requestPrice" INTEGER NOT NULL,
    "confirmPrice" INTEGER NOT NULL,
    "state" "RequestState" NOT NULL DEFAULT 'REQUESTED',
    "endDate" TIMESTAMP(3),
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserRequests_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "UserChatHistory" (
    "index" SERIAL NOT NULL,
    "chatId" TEXT NOT NULL,
    "senderId" TEXT NOT NULL,
    "msgType" "MsgType" NOT NULL,
    "content" TEXT NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserChatHistory_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "TestResult" (
    "index" SERIAL NOT NULL,
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "TestType" "TestType" NOT NULL,
    "sheetId" TEXT NOT NULL,
    "sheetInput" JSONB NOT NULL,
    "result" TEXT NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TestResult_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "UserReporting" (
    "index" SERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "ReportType" "ReportType" NOT NULL,
    "innerId" TEXT NOT NULL,
    "msg" TEXT NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserReporting_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ScamNews" (
    "index" SERIAL NOT NULL,
    "id" TEXT NOT NULL,
    "media" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "summary" TEXT NOT NULL,
    "img" TEXT,
    "link" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "publishAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ScamNews_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ScamNewsViewCnt" (
    "index" SERIAL NOT NULL,
    "newsId" TEXT NOT NULL,
    "viewCnt" INTEGER NOT NULL,
    "startAt" TIMESTAMP(3) NOT NULL,
    "endAt" TIMESTAMP(3) NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ScamNewsViewCnt_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ScamCategory" (
    "index" SERIAL NOT NULL,
    "group" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ScamCategory_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ScamCasePost" (
    "index" SERIAL NOT NULL,
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "categoryId" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "summary" TEXT NOT NULL,
    "content" JSONB NOT NULL,
    "bestExpertCommentId" TEXT,
    "viewCnt" INTEGER NOT NULL DEFAULT 0,
    "tag" TEXT[],
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ScamCasePost_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ScamCaseUserComment" (
    "index" SERIAL NOT NULL,
    "scamPostId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "comment" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ScamCaseUserComment_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ScamCaseExpertComment" (
    "index" SERIAL NOT NULL,
    "id" TEXT NOT NULL,
    "scamPostId" TEXT NOT NULL,
    "comment" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expertId" TEXT NOT NULL,

    CONSTRAINT "ScamCaseExpertComment_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ScamCaseTag" (
    "index" SERIAL NOT NULL,
    "tag" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ScamCaseTag_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ScamDictionary" (
    "index" SERIAL NOT NULL,
    "id" TEXT NOT NULL,
    "categoryId" INTEGER NOT NULL,
    "cardImage" TEXT,
    "headerImg" TEXT,
    "title" TEXT NOT NULL,
    "author" TEXT NOT NULL,
    "expertId" TEXT,
    "content" JSONB NOT NULL,
    "nextDictionaryId" TEXT,
    "isPremium" BOOLEAN NOT NULL DEFAULT false,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ScamDictionary_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ScamDictionaryComment" (
    "index" SERIAL NOT NULL,
    "id" TEXT NOT NULL,
    "dictionaryId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "comment" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ScamDictionaryComment_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ScamDictionaryViewCnt" (
    "index" SERIAL NOT NULL,
    "dictionaryId" TEXT NOT NULL,
    "viewCnt" INTEGER NOT NULL,
    "startAt" TIMESTAMP(3) NOT NULL,
    "endAt" TIMESTAMP(3) NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ScamDictionaryViewCnt_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "Expert" (
    "index" SERIAL NOT NULL,
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "company" TEXT DEFAULT '기본 사무소',
    "icon" TEXT,
    "description" TEXT,
    "headerImg" TEXT,
    "bio" TEXT,
    "service" TEXT[],
    "badge" TEXT[],
    "requestCnt" INTEGER NOT NULL DEFAULT 0,
    "starCnt" INTEGER NOT NULL DEFAULT 0,
    "totalCareer" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Expert_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ExpertCapacity" (
    "index" SERIAL NOT NULL,
    "expertId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "img" TEXT NOT NULL,
    "issueDate" TIMESTAMP(3) NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ExpertCapacity_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ExpertCareer" (
    "index" SERIAL NOT NULL,
    "expertId" TEXT NOT NULL,
    "organization" TEXT NOT NULL,
    "work" TEXT NOT NULL,
    "startAt" TIMESTAMP(3) NOT NULL,
    "endAt" TIMESTAMP(3) NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ExpertCareer_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ExpertReview" (
    "index" SERIAL NOT NULL,
    "expertId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "requestId" TEXT NOT NULL,
    "starCnt" INTEGER NOT NULL DEFAULT 5,
    "conmment" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ExpertReview_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "ExpertOffice" (
    "index" SERIAL NOT NULL,
    "expertId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ExpertOffice_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "Posts" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "firstImg" TEXT,
    "description" TEXT,
    "category" TEXT NOT NULL,
    "content" JSONB NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isdelete" BOOLEAN NOT NULL DEFAULT false,
    "author" TEXT,

    CONSTRAINT "Posts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CrawlingStateChecker" (
    "index" SERIAL NOT NULL,
    "origin" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "description" TEXT,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "category" TEXT NOT NULL,
    "state" "CrawlingState" NOT NULL DEFAULT 'READY',

    CONSTRAINT "CrawlingStateChecker_pkey" PRIMARY KEY ("index")
);

-- CreateTable
CREATE TABLE "CrawlingData" (
    "index" SERIAL NOT NULL,
    "info" TEXT,
    "siteName" TEXT,
    "category" TEXT,
    "title" TEXT,
    "gptTitle" TEXT,
    "question" TEXT,
    "qptQuestion" TEXT,
    "answer" TEXT,
    "qptAnswer" TEXT,
    "tags" TEXT[],
    "link" TEXT,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CrawlingData_pkey" PRIMARY KEY ("index")
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_email_key" ON "Users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Users_phone_key" ON "Users"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "UserAccessTokens_userId_platform_key" ON "UserAccessTokens"("userId", "platform");

-- CreateIndex
CREATE UNIQUE INDEX "UserChatList_id_key" ON "UserChatList"("id");

-- CreateIndex
CREATE UNIQUE INDEX "UserRequests_id_key" ON "UserRequests"("id");

-- CreateIndex
CREATE UNIQUE INDEX "TestResult_id_key" ON "TestResult"("id");

-- CreateIndex
CREATE UNIQUE INDEX "ScamNews_id_key" ON "ScamNews"("id");

-- CreateIndex
CREATE UNIQUE INDEX "ScamCategory_title_key" ON "ScamCategory"("title");

-- CreateIndex
CREATE UNIQUE INDEX "ScamCasePost_id_key" ON "ScamCasePost"("id");

-- CreateIndex
CREATE UNIQUE INDEX "ScamCaseExpertComment_id_key" ON "ScamCaseExpertComment"("id");

-- CreateIndex
CREATE UNIQUE INDEX "ScamCaseTag_tag_key" ON "ScamCaseTag"("tag");

-- CreateIndex
CREATE UNIQUE INDEX "ScamDictionary_id_key" ON "ScamDictionary"("id");

-- CreateIndex
CREATE UNIQUE INDEX "ScamDictionaryComment_id_key" ON "ScamDictionaryComment"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Expert_id_key" ON "Expert"("id");

-- CreateIndex
CREATE UNIQUE INDEX "CrawlingStateChecker_url_key" ON "CrawlingStateChecker"("url");

-- AddForeignKey
ALTER TABLE "Accounts" ADD CONSTRAINT "Accounts_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAccessTokens" ADD CONSTRAINT "UserAccessTokens_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserChatList" ADD CONSTRAINT "UserChatList_expertId_fkey" FOREIGN KEY ("expertId") REFERENCES "Expert"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserChatList" ADD CONSTRAINT "UserChatList_requestId_fkey" FOREIGN KEY ("requestId") REFERENCES "UserRequests"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserChatList" ADD CONSTRAINT "UserChatList_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserRequests" ADD CONSTRAINT "UserRequests_expertId_fkey" FOREIGN KEY ("expertId") REFERENCES "Expert"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserChatHistory" ADD CONSTRAINT "UserChatHistory_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES "UserChatList"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserChatHistory" ADD CONSTRAINT "UserChatHistory_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestResult" ADD CONSTRAINT "TestResult_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserReporting" ADD CONSTRAINT "UserReporting_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScamNewsViewCnt" ADD CONSTRAINT "ScamNewsViewCnt_newsId_fkey" FOREIGN KEY ("newsId") REFERENCES "ScamNews"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScamCasePost" ADD CONSTRAINT "ScamCasePost_bestExpertCommentId_fkey" FOREIGN KEY ("bestExpertCommentId") REFERENCES "ScamCaseExpertComment"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScamCasePost" ADD CONSTRAINT "ScamCasePost_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "ScamCategory"("index") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScamCasePost" ADD CONSTRAINT "ScamCasePost_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScamCaseUserComment" ADD CONSTRAINT "ScamCaseUserComment_scamPostId_fkey" FOREIGN KEY ("scamPostId") REFERENCES "ScamCasePost"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScamCaseUserComment" ADD CONSTRAINT "ScamCaseUserComment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScamCaseExpertComment" ADD CONSTRAINT "ScamCaseExpertComment_expertId_fkey" FOREIGN KEY ("expertId") REFERENCES "Expert"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScamCaseExpertComment" ADD CONSTRAINT "ScamCaseExpertComment_scamPostId_fkey" FOREIGN KEY ("scamPostId") REFERENCES "ScamCasePost"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScamDictionary" ADD CONSTRAINT "ScamDictionary_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "ScamCategory"("index") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScamDictionary" ADD CONSTRAINT "ScamDictionary_expertId_fkey" FOREIGN KEY ("expertId") REFERENCES "Expert"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScamDictionaryComment" ADD CONSTRAINT "ScamDictionaryComment_dictionaryId_fkey" FOREIGN KEY ("dictionaryId") REFERENCES "ScamDictionary"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScamDictionaryComment" ADD CONSTRAINT "ScamDictionaryComment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScamDictionaryViewCnt" ADD CONSTRAINT "ScamDictionaryViewCnt_dictionaryId_fkey" FOREIGN KEY ("dictionaryId") REFERENCES "ScamDictionary"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExpertCapacity" ADD CONSTRAINT "ExpertCapacity_expertId_fkey" FOREIGN KEY ("expertId") REFERENCES "Expert"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExpertCareer" ADD CONSTRAINT "ExpertCareer_expertId_fkey" FOREIGN KEY ("expertId") REFERENCES "Expert"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExpertReview" ADD CONSTRAINT "ExpertReview_expertId_fkey" FOREIGN KEY ("expertId") REFERENCES "Expert"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExpertOffice" ADD CONSTRAINT "ExpertOffice_expertId_fkey" FOREIGN KEY ("expertId") REFERENCES "Expert"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
