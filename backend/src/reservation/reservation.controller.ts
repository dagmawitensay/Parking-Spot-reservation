import { Controller, Post, Get, Put, Delete,  ParseIntPipe, Param, Body } from '@nestjs/common';
import { ReservationService } from './reservation.service';
import { ReservationDto } from './dto';

@Controller('reservations')
export class ReservationController {
    constructor(private reservationService: ReservationService) {}

    @Post()
    createReservation(
    @Body('user_id', ParseIntPipe) user_id: number,
    @Body('spot_id', ParseIntPipe) spot_id: number,
    @Body() dto: ReservationDto) {
        return this.reservationService.makeReservation(user_id, spot_id ,dto)
    }

    @Get()
    getAllUserReservations(@Body('user_id', ParseIntPipe) user_id: number) {
        return this.reservationService.getUserReservations(user_id)
    }

    @Get(':compound_id')
    getAvailableSpots(@Param('compound_id', ParseIntPipe) compound_id: number, @Body('user_id', ParseIntPipe) user_id: number,  @Body() dto: ReservationDto) {
        return this.reservationService.hasAvailableSpots(compound_id, user_id, dto);
    }

    @Put(':reservation_id')
    updateReservationDetail(@Param('reservation_id', ParseIntPipe) reservation_id: number, dto: ReservationDto) {
        return this.reservationService.updateReservationDetail(reservation_id, dto)
    }

    @Delete(':reservation_id')
    deleteReservation(@Param('reservation_id', ParseIntPipe) reservation_id: number) {
        return this.reservationService.deleteReservation(reservation_id)
    }

    @Delete()
    deleteAllReservations(@Body('compound_id', ParseIntPipe) compound_id: number) {
        return this.reservationService.deleteAllReservations(compound_id)
    }
}
