import { Body, Controller, Get, Post, Req } from '@nestjs/common';
import { Request } from 'express';
import { AuthService } from './auth.service';
import { AuthDtoType } from './dto';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}
  @Get('expert')
  expert() {
    return this.authService.expert();
  }

  @Post('signup')
  signup(@Body() dto: AuthDtoType) {
    console.log('auth-Controller req', dto);

    return this.authService.signup(dto);
  }
  @Post('signin')
  signin() {
    return 'success signIn';
  }

  @Get()
  findAll(@Req() request: Request): string {
    return 'This action returns all cats';
  }
}
