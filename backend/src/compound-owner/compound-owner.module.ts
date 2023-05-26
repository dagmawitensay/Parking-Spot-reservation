import { Module } from '@nestjs/common';
import { CompoundOwnerService } from './compound-owner.service';

@Module({
  providers: [CompoundOwnerService]
})
export class CompoundOwnerModule {}
