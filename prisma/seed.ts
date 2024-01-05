import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient({ log: ['query', 'info', 'warn', 'error'] });
async function main() {
  const alice = await prisma.expert.create({
    data: {
      headerImg: '/images/expert-profile-bg.jpg',
      name: '조대진',
      icon: '/images/expert-profile.jpg',
      description: '이해의 폭을 넓혀서 최선의 결과를 만들겠습니다.',
      badge: ['본인인증', '사업자 등록증', '변호사 인증'],
      bio: '의뢰인으로 부터 사건에 최선을 다해주셔서 고맙다는 말을 들을 수 있도록 항상 마음을 다하는 변호사가 되겠습니다.',
      service: ['증거수집', '계약 작성', '지식재산권', '기업법'],
      requestCnt: 100,
      starCnt: 4.3,
      totalCareer: 10,
    },
  });
  console.log(alice);
}
main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
