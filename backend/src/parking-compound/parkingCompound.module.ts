import { Module } from "@nestjs/common";
import { ParkingCompoundService } from "./parkingCompound.service";
import { ParkingCompoundCotroller } from "./parkingCompound.controller";
import { PrismaService } from "src/prisma/prisma.service";
import { ParkingSpotService } from "src/parking-spot/parking-spot.service";

@Module({
    providers: [ParkingCompoundService, PrismaService, ParkingSpotService],
    controllers: [ParkingCompoundCotroller],
})
export class ParkingCompoundModule {
    
}