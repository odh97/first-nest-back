import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { CatsModule } from './cats/cats.module';
import { UserModule } from './user/user.module';
import { BookmarkModule } from './bookmark/bookmark.module';
import { PrismaModule } from './prisma/prisma.module';
import { ExpertModule } from './expert/expert.module';

@Module({
  imports: [
    AuthModule,
    CatsModule,
    UserModule,
    BookmarkModule,
    PrismaModule,
    ExpertModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
