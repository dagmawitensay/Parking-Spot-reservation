import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put } from "@nestjs/common";
import { ParkingCompoundService } from "./parkingCompound.service";
import { ParkingCompoundDto } from "./dto";
import { combineLatest } from "rxjs";

@Controller('parking-compounds')
export class ParkingCompoundCotroller {
    constructor(private parkingCompoundService: ParkingCompoundService) {}
    
    @Post()
    create_parking_compound(@Body('owner_id', ParseIntPipe) owner_id: number, @Body() dto: ParkingCompoundDto) {
        return this.parkingCompoundService.create_parking_compound(owner_id, dto)
    }

    @Put(':compound_id')
    update_parking_compound(@Param('compound_id', ParseIntPipe) compound_id: number,  @Body() dto: ParkingCompoundDto) {
        return this.parkingCompoundService.edit_parking_compound(compound_id, dto)
    }

    // get parking compound for specific owner
    @Get(':compound_id')
    find_compound(@Param('compound_id', ParseIntPipe) compound_id: number,  @Body() dto: ParkingCompoundDto) {
        return this.parkingCompoundService.getCompound(compound_id)
    }

    // get all compunds
    @Get()
    getAll() {
        return this.parkingCompoundService.getAllCompounds()
    }

    // get all compuonds by the owner
    @Get()
    getAllCompoundsByOwner(@Param('owner_id', ParseIntPipe) owner_id: number,
    ) {
        return this.parkingCompoundService.getAllCompoundsByOwner(owner_id)
    }

    @Delete(':compound_id')
    deleteParkingCompound(@Param('compound_id', ParseIntPipe) compound_id: number) {
        return this.parkingCompoundService.deleteParkingCompound(compound_id)
    }
    
}