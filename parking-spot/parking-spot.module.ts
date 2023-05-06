import { Module } from '@nestjs/common';
import { ParkingSpotService } from './parking-spot.service';
import { ParkingSpotController } from './parking-spot.controller';

@Module({
  providers: [ParkingSpotService],
  controllers: [ParkingSpotController]
})
export class ParkingSpotModule {}
