import { Module } from '@nestjs/common';
import { SpotUserService } from './spot-user.service';

@Module({
  providers: [SpotUserService]
})
export class SpotUserModule {}
