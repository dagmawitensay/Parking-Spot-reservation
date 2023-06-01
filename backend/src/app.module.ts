import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';
import { prismaModule } from './prisma/prisma.module';
import { SpotUserModule } from './spot-user/spot-user.module';
import { CompoundOwnerModule } from './compound-owner/compound-owner.module';
import { APP_GUARD } from '@nestjs/core';
import { RolesGuard } from './auth/guard/role.guard';
import { JwtStrategy } from './auth/strategy';
import { JwtGuard } from './auth/guard';
import { UserModule } from './user/user.module';
import { ParkingCompoundModule } from './parking-compound/parkingCompound.module';
import { ReservationModule } from './reservation/reservation.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal:true,
    }),
    AuthModule,
    prismaModule,
    CompoundOwnerModule,
    SpotUserModule,
    UserModule,
    ParkingCompoundModule,
    ReservationModule
  ]
  // providers: [
  //   JwtStrategy
  //   // {
  //   //   provide: APP_GUARD,
  //   //   useClass: RolesGuard,
  //   // }
   
  // ]
})
export class AppModule {}
