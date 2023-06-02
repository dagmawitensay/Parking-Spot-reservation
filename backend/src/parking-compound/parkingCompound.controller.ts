import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put, UseGuards } from "@nestjs/common";
import { ParkingCompoundService } from "./parkingCompound.service";
import { ParkingCompoundDto } from "./dto";
import { combineLatest } from "rxjs";
import { Role } from "src/auth/decorator/role.enum";
import { JwtGuard } from "src/auth/guard";
import { RolesGuard } from "src/auth/guard/role.guard";
import { Roles } from "src/auth/decorator/roles.decorator";



@Controller('parking-compounds')

export class ParkingCompoundCotroller {
    constructor(private parkingCompoundService: ParkingCompoundService) {}
    
    @Roles(Role.owner)
    @UseGuards(JwtGuard, )
    @Post()
    create_parking_compound(@Body('owner_id', ParseIntPipe) owner_id: number, @Body() dto: ParkingCompoundDto) {
        return this.parkingCompoundService.create_parking_compound(owner_id, dto)
    }
     
    @Roles(Role.owner)
    @UseGuards(JwtGuard, )
    @Put(':compound_id')
    update_parking_compound(@Param('compound_id', ParseIntPipe) compound_id: number,  @Body() dto: ParkingCompoundDto) {
        return this.parkingCompoundService.edit_parking_compound(compound_id, dto)
    }


    // get parking compound for specific owner
    @Get(':compound_id')
    find_compound(@Param('compound_id', ParseIntPipe) compound_id: number) {
        return this.parkingCompoundService.getCompound(compound_id)
    }

    // get all compunds
    @Get()
    getAll() {
        return this.parkingCompoundService.getAllCompounds()
    }

    @Roles(Role.owner)
    @UseGuards(JwtGuard, )
    // get all compuonds by the owner
    @Get(':owner_id')
    getAllCompoundsByOwner(@Param('owner_id', ParseIntPipe) owner_id: number,
    ) {
        return this.parkingCompoundService.getAllCompoundsByOwner(owner_id)
    }

    @Roles(Role.owner)
    @UseGuards(JwtGuard, )
    @Delete(':compound_id')
    deleteParkingCompound(@Param('compound_id', ParseIntPipe) compound_id: number) {
        return this.parkingCompoundService.deleteParkingCompound(compound_id)
    }
    
}