import { Controller, Post, Get, Put, Delete,  ParseIntPipe, Param, Body, UseGuards } from '@nestjs/common';
import { ReservationService } from './reservation.service';
import { ReservationDto } from './dto';
import { Role } from 'src/auth/decorator/role.enum';
import { Roles } from 'src/auth/decorator/roles.decorator';
import { JwtGuard } from 'src/auth/guard';

@Controller('reservations')
export class ReservationController {
    constructor(private reservationService: ReservationService) {}
    @Roles(Role.reserver)
    @UseGuards(JwtGuard, )
    @Post()
    createReservation(
    @Body('user_id', ParseIntPipe) user_id: number,
    @Body('spot_id', ParseIntPipe) spot_id: number,
    @Body() dto: ReservationDto) {
        return this.reservationService.makeReservation(user_id, spot_id ,dto)
    }

    @Post(':compound_id')
    getAvailableSpots(@Param('compound_id', ParseIntPipe) compound_id: number, @Body('user_id', ParseIntPipe) user_id: number,  @Body() dto: ReservationDto) {
        return this.reservationService.hasAvailableSpots(compound_id, user_id, dto);
    }

    @Get(':user_id')
    getAllUserReservations(@Param('user_id', ParseIntPipe) user_id: number) {
        return this.reservationService.getUserReservations(user_id)
    }

    @Roles(Role.reserver)
    @UseGuards(JwtGuard, )
    @Put(':reservation_id')
    updateReservationDetail(@Param('reservation_id', ParseIntPipe) reservation_id: number, dto: ReservationDto) {
        return this.reservationService.updateReservationDetail(reservation_id, dto)
    }

    // @Roles(Role.reserver)
    @UseGuards(JwtGuard, )
    @Delete(':reservation_id')
    deleteReservation(@Param('reservation_id', ParseIntPipe) reservation_id: number) {
        return this.reservationService.deleteReservation(reservation_id)
    }

    @Delete()
    deleteAllReservations(@Body('compound_id', ParseIntPipe) compound_id: number) {
        return this.reservationService.deleteAllReservations(compound_id)
    }
}
