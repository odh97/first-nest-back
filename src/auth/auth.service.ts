import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { AuthDtoType } from './dto';

@Injectable({})
export class AuthService {
  expertReviewData = [
    {
      img: '',
      userId: '이국적인달빛',
      starCnt: 4.3,
      comment:
        '다른 업체에 맡겨서 번번히 실패했는데 이틀만에 증거 보내주시고 정말 12시간 이상 밀착하여 보내주신 사진.. 증거자료로 상간자 소송 잘 했습니다. 감사합니다!',
      createAt: '2023.11.11 01:00:12',
    },
    {
      img: '',
      userId: '이국적인달빛',
      starCnt: 4.3,
      comment:
        '다른 업체에 맡겨서 번번히 실패했는데 이틀만에 증거 보내주시고 정말 12시간 이상 밀착하여 보내주신 사진.. 증거자료로 상간자 소송 잘 했습니다. 감사합니다!',
      createAt: '2023.11.11 01:00:12',
    },
    {
      img: '',
      userId: '이국적인달빛',
      starCnt: 4.3,
      comment:
        '다른 업체에 맡겨서 번번히 실패했는데 이틀만에 증거 보내주시고 정말 12시간 이상 밀착하여 보내주신 사진.. 증거자료로 상간자 소송 잘 했습니다. 감사합니다!',
      createAt: '2023.11.11 01:00:12',
    },
    {
      img: '',
      userId: '이국적인달빛',
      starCnt: 4.3,
      comment:
        '다른 업체에 맡겨서 번번히 실패했는데 이틀만에 증거 보내주시고 정말 12시간 이상 밀착하여 보내주신 사진.. 증거자료로 상간자 소송 잘 했습니다. 감사합니다!',
      createAt: '2023.11.11 01:00:12',
    },
    {
      img: '',
      userId: '이국적인달빛',
      starCnt: 4.3,
      comment:
        '다른 업체에 맡겨서 번번히 실패했는데 이틀만에 증거 보내주시고 정말 12시간 이상 밀착하여 보내주신 사진.. 증거자료로 상간자 소송 잘 했습니다. 감사합니다!',
      createAt: '2023.11.11 01:00:12',
    },
    {
      img: '',
      userId: '이국적인달빛',
      starCnt: 4.3,
      comment:
        '다른 업체에 맡겨서 번번히 실패했는데 이틀만에 증거 보내주시고 정말 12시간 이상 밀착하여 보내주신 사진.. 증거자료로 상간자 소송 잘 했습니다. 감사합니다!',
      createAt: '2023.11.11 01:00:12',
    },
    {
      img: '',
      userId: '이국적인달빛',
      starCnt: 4.3,
      comment:
        '다른 업체에 맡겨서 번번히 실패했는데 이틀만에 증거 보내주시고 정말 12시간 이상 밀착하여 보내주신 사진.. 증거자료로 상간자 소송 잘 했습니다. 감사합니다!',
      createAt: '2023.11.11 01:00:12',
    },
    {
      img: '',
      userId: '이국적인달빛',
      starCnt: 4.3,
      comment:
        '다른 업체에 맡겨서 번번히 실패했는데 이틀만에 증거 보내주시고 정말 12시간 이상 밀착하여 보내주신 사진.. 증거자료로 상간자 소송 잘 했습니다. 감사합니다!',
      createAt: '2023.11.11 01:00:12',
    },
    {
      img: '',
      userId: '이국적인달빛',
      starCnt: 4.3,
      comment:
        '다른 업체에 맡겨서 번번히 실패했는데 이틀만에 증거 보내주시고 정말 12시간 이상 밀착하여 보내주신 사진.. 증거자료로 상간자 소송 잘 했습니다. 감사합니다!',
      createAt: '2023.11.11 01:00:12',
    },
    {
      img: '',
      userId: '이국적인달빛',
      starCnt: 4.3,
      comment:
        '다른 업체에 맡겨서 번번히 실패했는데 이틀만에 증거 보내주시고 정말 12시간 이상 밀착하여 보내주신 사진.. 증거자료로 상간자 소송 잘 했습니다. 감사합니다!',
      createAt: '2023.11.11 01:00:12',
    },
  ];
  expertData = {
    id: 'Cho - user ID',

    headerImg: '/images/expert-profile-bg.jpg',

    name: '조대진 변호사님',
    icon: '/images/expert-profile.jpg',
    description: '이해의 폭을 넓혀서 최선의 결과를 만들겠습니다.',
    badge: ['본인인증', '사업자 등록증', '변호사 인증'],

    bio: '의뢰인으로 부터 사건에 최선을 다해주셔서 고맙다는 말을 들을 수 있도록 항상 마음을 다하는 변호사가 되겠습니다.',
    service: ['증거수집', '계약 작성', '지식재산권', '기업법'],

    requestCnt: 100,
    starCnt: 4.3,
    totalCareer: 10,

    expertCapacity: [
      {
        title: '변호사',
        img: '',
        issueDate: '2017',
      },
      {
        title: '탐정사',
        img: '',
        issueDate: '2022',
      },
      {
        title: '세무사',
        img: '',
        issueDate: '2014',
      },
      {
        title: '변리사',
        img: '',
        issueDate: '2017',
      },
      {
        title: '변리사',
        img: '',
        issueDate: '2017',
      },
      {
        title: '변리사',
        img: '',
        issueDate: '2017',
      },
    ],
    expertCareer: [
      { organization: '법무법인 해냄', date: '2022.01.01~2023.02.10' },
      { organization: '법무법인 해냄', date: '2022.01.01~2023.02.10' },
      { organization: '법무법인 해냄', date: '2022.01.01~2023.02.10' },
      { organization: '법무법인 해냄', date: '2022.01.01~2023.02.10' },
    ],
    expertReview: this.expertReviewData,
    expertOffice: {
      title: '윈앤파트너스 법률사무소',
      description: '서울특별시 강남구 선릉로 433(역삼동) 세방빌딩 15층',
      latitude: 37.504, // 위도
      longitude: 127.048, // 경도
    },
  };

  constructor(private prisma: PrismaService) {}

  expert() {
    return this.expertData;
  }

  signup(req: AuthDtoType) {
    console.log(req);
  }
  signin() {
    return 'Signup';
  }
}
