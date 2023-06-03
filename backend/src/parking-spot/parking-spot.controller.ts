import { Controller, Get, Param, ParseIntPipe, Post, Put } from '@nestjs/common';
import { ParkingSpotService } from './parking-spot.service';

@Controller('parking_compunds/:compound_id/parking-spots')
export class ParkingSpotController {
    constructor(private parkingSpotService: ParkingSpotService) {}

    @Post()
    createParkingSpot(@Param('compound_id') compound_id:number) {
        return this.parkingSpotService.createParkingSpot(compound_id)
    }

    @Get(':parking_spot_id')
    getParkingSpot(@Param('parking_spot_id', ParseIntPipe) parking_spot_id: number, ) {
        return this.parkingSpotService.getParkingSpot(parking_spot_id)
    }

    // get all parking spots of a compound
    @Get()
    getAllParkingSpots(@Param('compound_id', ParseIntPipe) compound_id: number) {
        return  this.parkingSpotService.getAllParkingSpots(compound_id)
    }

    @Put(':parking_spot_id')
    updateParkingSpot(@Param('parking_spot_id') parking_spot_id: number) {
        return this.parkingSpotService.updateParkingSpot(parking_spot_id)
    }




}
