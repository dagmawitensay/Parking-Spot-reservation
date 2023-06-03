import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { ParkingSpotDto } from './dto';

@Injectable()
export class ParkingSpotService {
    constructor(private prisma: PrismaService) {}

    async createParkingSpot(compound_id: number) {
        const parking_spot = await this.prisma.parking_spots.create(
            {
                data: {
                    compund_id: compound_id
                }
            }
        );

        return parking_spot;
    }


    async updateParkingSpot(parking_spot_id: number) {
        const parking_spot = await this.prisma.parking_spots.findUnique(
            {
                where: {
                    id: parking_spot_id
                },
            }
         )
    
    }

    async getParkingSpot(parking_spot_id: number) {
        const parking_spot = await this.prisma.parking_spots.findUnique({
            where: {

                id: parking_spot_id
            }
        });

        if (!parking_spot) return `No parking spot found with id ${parking_spot_id}`
        
        return parking_spot;

    }

    async getAllParkingSpots(compound_id: number) {
        const parking_spots = await this.prisma.parking_spots.findMany({
            where: {
                compund_id: compound_id
            }
        })

        return parking_spots;
    }

    async deleteParkingSpot(compound_id: number, pakring_spot_id: number,) {
        
        const parking_compound = await this.prisma.parking_compound.findFirst({
            where: {
                id: compound_id,
            }
        });
        if (!parking_compound) throw (`No parking compound with id ${compound_id}`)

        const parking_spot = await this.prisma.parking_spots.delete(
            {
                where: {
                    id: pakring_spot_id,
                }
            }
        )

        if (!parking_spot) throw (`No parking spot with ${pakring_spot_id} in a compound with compound id ${compound_id}`)
        
        await this.prisma.parking_compound.update({
            where: {
                id: compound_id
            },
            data: {
                total_spots: {
                    decrement: 1
                },
                available_spots: {
                    decrement: 0? 0: 1
                }
            }
        })
        return {message: `Parking spot with id ${pakring_spot_id} have been deleted`}
    }
}
