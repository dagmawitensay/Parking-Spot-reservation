import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserModule } from './user/user.module';
import { ParkingSpotModule } from './parking-spot/parking-spot.module';
import { ReservationModule } from './reservation/reservation.module';
import { AuthModule } from './Auth/auth.module';
import { ParkingCompoundModule } from './parking-compound/parkingCompound.module';
import { PrismaModule } from './prisma/prisma.module';

@Module({
  imports: [UserModule, ParkingSpotModule, ReservationModule, AuthModule, PrismaModule, ParkingCompoundModule, ParkingSpotModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
