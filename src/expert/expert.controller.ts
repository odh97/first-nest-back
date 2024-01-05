import { Controller, Get, Param, Post } from '@nestjs/common';
import { ExpertService } from './expert.service';

@Controller('expert')
export class ExpertController {
  constructor(private expertService: ExpertService) {}

  @Get('/:id')
  expertProfileFind(@Param('id') id: string) {
    console.log('expert controller expertProfileFind');
    return this.expertService.expertProfileFind(id);
  }

  @Post('/signUp')
  expertSignUp() {
    console.log('expert signUp controller');
    return this.expertService.expertSignUp();
  }

  @Post('/:id/addReview')
  expertAddReview(@Param('id') id: string) {
    console.log('expert add review controller');
    return this.expertService.expertAddReview(id);
  }
}
