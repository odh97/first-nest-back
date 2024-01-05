import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Expert } from '@prisma/client';

@Injectable({})
export class ExpertService {
  expertData = {
    headerImg: '/images/expert-profile-bg.jpg',

    name: '조대진 변호사님',
    icon: '/images/expert-profile.jpg',
    description: '이해의 폭을 넓혀서 최선의 결과를 만들겠습니다.',
    badge: ['본인인증', '사업자 등록증', '변호사 인증'],

    bio: '의뢰인으로 부터 사건에 최선을 다해주셔서 고맙다는 말을 들을 수 있도록 항상 마음을 다하는 변호사가 되겠습니다.',
    service: ['증거수집', '계약 작성', '지식재산권', '기업법'],

    requestCnt: 100,
    starCnt: 4,
    totalCareer: 10,
  };

  expertCapacity = [
    {
      title: '변호사',
      img: '',
      issueDate: '2024-01-04T12:34:56Z',
    },
    {
      title: '탐정사',
      img: '',
      issueDate: '2024-01-04T12:34:56Z',
    },
    {
      title: '세무사',
      img: '',
      issueDate: '2024-01-04T12:34:56Z',
    },
    {
      title: '변리사',
      img: '',
      issueDate: '2024-01-04T12:34:56Z',
    },
    {
      title: '변리사',
      img: '',
      issueDate: '2024-01-04T12:34:56Z',
    },
    {
      title: '변리사',
      img: '',
      issueDate: '2024-01-04T12:34:56Z',
    },
  ];
  expertCareer = [
    {
      organization: '법무법인 해냄',
      startAt: '2022-01-01T12:34:56Z',
      endAt: '2023-02-10T12:34:56Z',
    },
    {
      organization: '법무법인 해냄',
      startAt: '2022-01-01T12:34:56Z',
      endAt: '2023-02-10T12:34:56Z',
    },
    {
      organization: '법무법인 해냄',
      startAt: '2022-01-01T12:34:56Z',
      endAt: '2023-02-10T12:34:56Z',
    },
    {
      organization: '법무법인 해냄',
      startAt: '2022-01-01T12:34:56Z',
      endAt: '2023-02-10T12:34:56Z',
    },
  ];
  expertOffice = {
    title: '윈앤파트너스 법률사무소',
    description: '서울특별시 강남구 선릉로 433(역삼동) 세방빌딩 15층',
    latitude: 37.504, // 위도
    longitude: 127.048, // 경도
  };

  expertReview = {
    userId: 'clqezb4t5001vcwdmm219h378',
    starCnt: 4,
    requestId: 'test1',
    comment:
      '다른 업체에 맡겨서 번번히 실패했는데 이틀만에 증거 보내주시고 정말 12시간 이상 밀착하여 보내주신 사진.. 증거자료로 상간자 소송 잘 했습니다. 감사합니다!',
  };

  constructor(private db: PrismaService) {}

  expertProfileFind(id: string): Promise<Expert | null> {
    console.log('expert service', id);
    try {
      return this.db.expert.findUnique({
        where: { id },
        include: {
          ExpertCapacity: true,
          ExpertCareer: true,
          ExpertReview: {
            include: {
              users: true,
            },
          },
          ExpertOffice: true,
        },
      });
    } catch (error) {
      console.log(error);
      return error;
    }
  }
  async expertSignUp() {
    console.log('expert Insert, service');
    try {
      const createExpert = await this.db.expert.create({
        data: this.expertData,
      });
      console.log(createExpert);

      for (const key of this.expertCapacity) {
        await this.db.expertCapacity.create({
          data: {
            ...key,
            expertId: createExpert.id,
            description: 'TEST',
          },
        });
      }

      for (const key of this.expertCareer) {
        await this.db.expertCareer.create({
          data: {
            ...key,
            expertId: createExpert.id,
            work: '변호사test',
          },
        });
      }

      await this.db.expertOffice.create({
        data: {
          ...this.expertOffice,
          expertId: createExpert.id,
        },
      });

      return this.db.expert.findUnique({
        where: { id: createExpert.id },
        include: {
          ExpertCapacity: true,
          ExpertCareer: true,
          ExpertOffice: true,
        },
      });
    } catch (error) {
      console.log(error);
      return error;
    }
  }
  async expertAddReview(id: string) {
    console.log('expert add Review, service');
    try {
      return this.db.expertReview.create({
        data: {
          ...this.expertReview,
          expertId: id,
        },
      });
    } catch (error) {
      console.log(error);
      return error;
    }
  }
}
