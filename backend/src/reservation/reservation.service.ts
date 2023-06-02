import { Injectable } from '@nestjs/common';
import { ReservationDto } from './dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class ReservationService {
    constructor(private prisma: PrismaService) {}
    async hasAvailableSpots(compound_id: number, user_id: number, dto: ReservationDto) {
        const existing_user_reservations = await this.prisma.reservations.findMany({
            where: {
                user_id: user_id
            }
        })

        const parking_spots = await this.prisma.parking_spots.findMany({
            where: {
                compund_id: compound_id
            }
        });

        const parking_spot_ids = parking_spots.map(p => p.id);
        console.log(parking_spot_ids);
        const reservations = []

        console.log(existing_user_reservations);
        for (let reservation of existing_user_reservations) {
            if ((new Date(dto.start_time) <= reservation.end_time && new Date(dto.end_time) >= reservation.start_time)
            || reservation.start_time <= new Date(dto.end_time) && reservation.end_time >= new Date(dto.start_time)){
                return {'parkingSpots': [[], parking_spot_ids]};
            }
        }


        for (let spot_id of parking_spot_ids){
            const reservation = await this.prisma.reservations.findMany({
                where: {
                    parking_spot_id: spot_id
                }
            })
            reservations.push(...reservation)
        }

        const reserved_spots_id = reservations.map(p => p.parking_spot_id);
        const unreserved_spots_id = parking_spot_ids.filter(p => !reserved_spots_id.includes(p))

        if (unreserved_spots_id.length > 0) {
            return {'parkingSpots': [unreserved_spots_id, parking_spot_ids]};
        } else {
            const reserved_at_time_spots_id = []

            for(let reservation of reservations) {
                if ((new Date(dto.start_time) <= reservation.end_time && new Date(dto.end_time) >= reservation.start_time)
                || reservation.start_time <= new Date(dto.end_time) && reservation.end_time >= new Date(dto.start_time)){
                    reserved_at_time_spots_id.push(reservation.parking_spot_id);   
                }
            }

            const available_spots = parking_spot_ids.filter(p => !reserved_at_time_spots_id.includes(p))

            if (available_spots.length > 0){
                return {'parkingSpots': [available_spots, parking_spot_ids]}
            }else {
                return {'parkingSpots' : [[], parking_spot_ids]};
            }
        }
}

//     async createReservation(compound_id: number, user_id: number, dto: ReservationDto) {
//         const existing_user_reservations = await this.prisma.reservations.findMany({
//             where: {
//                 user_id: user_id
//             }
//         })

//         for (let reservation of existing_user_reservations) {
//             if ((new Date(dto.start_time) <= reservation.end_time && new Date(dto.end_time) >= reservation.start_time)
//             || reservation.start_time <= new Date(dto.end_time) && reservation.end_time >= new Date(dto.start_time)){
//                 return "Can not make two reservatios at the same time"
//             }
//         }

//         const parking_spots = await this.prisma.parking_spots.findMany({
//             where: {
//                 compund_id: compound_id
//             }
//         });
//         const parking_spot_ids = parking_spots.map(p => p.id);
//         console.log(parking_spot_ids);
//         const reservations = []

//         for (let spot_id of parking_spot_ids){
//             const reservation = await this.prisma.reservations.findMany({
//                 where: {
//                     parking_spot_id: spot_id
//                 }
//             })
//             reservations.push(...reservation)
//         }

//         const reserved_spots_id = reservations.map(p => p.parking_spot_id);
//         const unreserved_spots_id = parking_spot_ids.filter(p => !reserved_spots_id.includes(p))

//         if (unreserved_spots_id.length > 0) {
//             return this.makeReservation(user_id, unreserved_spots_id[0],dto)
//         } else {
//             const reserved_at_time_spots_id = []

//             for(let reservation of reservations) {
//                 if ((new Date(dto.start_time) <= reservation.end_time && new Date(dto.end_time) >= reservation.start_time)
//                 || reservation.start_time <= new Date(dto.end_time) && reservation.end_time >= new Date(dto.start_time)){
//                     reserved_at_time_spots_id.push(reservation.parking_spot_id);   
//                 }
//             }

//             const available_spots = parking_spot_ids.filter(p => !reserved_at_time_spots_id.includes(p))

//             if (available_spots.length > 0){
//                 return this.makeReservation(user_id, available_spots[0], dto)
//             }else {
//                 return {msg: `All spots are reserved from ${dto.start_time} to ${dto.end_time} in this parking compound`}
//             }
//         }
// }

    async makeReservation(user_id: number, spot_id: number, dto: ReservationDto){
        console.log('backend')
        console.log(user_id);
        console.log(spot_id);
        console.log(dto);

        const reservation = await this.prisma.reservations.create({
            data: {
                user_id: user_id,
                parking_spot_id: spot_id,
                start_time:  new Date(dto.start_time).toISOString(),
                end_time: new Date(dto.end_time).toISOString()
            }
        });
        console.log(reservation);
        return reservation;
    }

    async getUserReservations(user_id: number) {
        const reservations = await this.prisma.reservations.findMany({
            where: {
                user_id: user_id
            }
        })

        return reservations;
    }

    async updateReservationDetail(reservation_id: number, dto: ReservationDto) {
        const reservation = await this.prisma.reservations.update({
            where: {
                id: reservation_id
            },
            data: {
                ...dto
            }
        })

        return reservation
    }

    async deleteReservation(reservation_id: number) {
        const reservation = await this.prisma.reservations.findUnique({
            where: {
                id: reservation_id
            }
        })

        if (!reservation) throw ("Reservation doesn't exist!")
        await this.prisma.reservations.delete({
            where: {
                id: reservation_id
            }
        })
        
        return {msg: `Reservation with id ${reservation_id} have been deleted`}
    }

    async deleteAllReservations(compound_id: number){
        const parking_spots = await this.prisma.parking_spots.findMany({
            where: {
                compund_id: compound_id
            }
        });
        
        const parking_spots_ids = parking_spots.map(p => p.id);

        for (let id of parking_spots_ids){
            const reservation = await this.prisma.reservations.findMany({
                where: {
                    parking_spot_id: id
                }
            });

            if (reservation.length == 0) continue;

        }
    }

}
