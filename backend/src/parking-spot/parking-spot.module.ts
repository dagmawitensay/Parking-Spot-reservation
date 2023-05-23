import { Module } from '@nestjs/common';
import { ParkingSpotService } from './parking-spot.service';
import { ParkingSpotController } from './parking-spot.controller';
import { PrismaService } from 'src/prisma/prisma.service';

@Module({
  providers: [ParkingSpotService, PrismaService],
  controllers: [ParkingSpotController]
})
export class ParkingSpotModule {

}
