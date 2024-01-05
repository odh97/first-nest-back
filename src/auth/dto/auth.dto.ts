import { IsEmail, IsNotEmpty, IsString } from 'class-validator';

export class AuthDtoType {
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @IsString()
  @IsNotEmpty()
  password: string;
}
