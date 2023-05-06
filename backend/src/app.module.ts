import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserModule } from './user/user.module';
import { ParkingSpotModule } from './parking-spot/parking-spot.module';
import { ReservationModule } from './reservation/reservation.module';

@Module({
  imports: [UserModule, ParkingSpotModule, ReservationModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
