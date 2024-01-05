import {
  Controller,
  Get,
  Post,
  Body,
  Req,
  Param,
  Redirect,
  Query,
} from '@nestjs/common';
import { CreateCatDto } from './dto/create-cat.dto';
import { CatsService } from './cats.service';
import { Cat } from './interfaces/cat.interface';
import { Request } from 'express';

@Controller('cats')
export class CatsController {
  constructor(private catsService: CatsService) {}

  @Post()
  // @useGuards(AuthGuard('jwt'))
  // @useInterceptors(FileUploadInterceptor)
  // @usePipes(new JoiValidationPipe(createCatSchema))
  async create(@Body() createCatDto: CreateCatDto) {
    console.log(createCatDto);

    return this.catsService.create(createCatDto);
  }

  // localhost:3000/cats
  @Get()
  async findAll(): Promise<Cat[]> {
    return this.catsService.findAll();
  }

  // localhost:3001/cats/cookie
  @Get('/cookie')
  getCookie(@Req() request: Request): string {
    return '쿠키';
  }

  // localhost:3001/cats/test
  @Get('/test')
  getTest(@Req() request: Request): string {
    return 'test';
  }

  // localhost:3001/cats/docs
  @Get('docs')
  @Redirect('https://docs.nestjs.com', 302)
  getDocs(@Query('version') version) {
    if (version && version === '5') {
      return { url: 'https://docs.nestjs.com/v5/' };
    }
  }

  // localhost:3001/cats/1
  @Get(':id')
  getList(@Param('id') id: string): string {
    return '종류별 고양이' + id;
  }

  // localhost:3001/cats/detail/1
  @Get('/detail/:id')
  getDetailList(@Param('id') id: string): string {
    return '종류별 고양이' + id;
  }
}
