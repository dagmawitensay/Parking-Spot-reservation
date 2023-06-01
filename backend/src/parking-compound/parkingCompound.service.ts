import { Injectable } from "@nestjs/common";
import { ParkingCompoundDto } from "./dto";
import { PrismaService } from "src/prisma/prisma.service";
import { ParkingSpotService } from "src/parking-spot/parking-spot.service";

@Injectable()
export class ParkingCompoundService {
    constructor(private prisma: PrismaService, private parkingSpotService: ParkingSpotService) {}

    async create_parking_compound(owner_id:number, dto: ParkingCompoundDto) {
    
        const parking_compound = await this.prisma.parking_compound.create({
            data: {
                name: dto.name,
                owner_id: owner_id,
                Region: dto.Region,
                Zone: dto.Zone,
                Wereda: dto.Wereda,
                Kebele: dto.Kebele,
                price: dto.price,
                available_spots: dto.available_spots,
                total_spots: dto.total_spots
            }
        });
      
        const compound_id = parking_compound.id;
        for(let i = 0; i < parking_compound.total_spots; i++) {
            await this.parkingSpotService.createParkingSpot(compound_id);
        }

        return parking_compound;
    }

    async edit_parking_compound(compound_id: number, dto: ParkingCompoundDto) {
        const parking_compound = await this.prisma.parking_compound.update(
            {
                where: {
                    id: compound_id
                },
                data: {
                    price: dto.price,
                    available_spots: dto.available_spots,
                    total_spots: dto.total_spots
                }
            }
        );

        return parking_compound;
    }

    async deleteParkingCompound(id: number) {
        const parking_compound_with_id  = await this.prisma.parking_compound.findFirst({
            where: {
                id: id
            }
        });

        if (!parking_compound_with_id) throw (`Parking compound with id ${id} doesn't exist`)

        const compound_id = parking_compound_with_id.id;
        const childParkingSpots = await this.parkingSpotService.getAllParkingSpots(compound_id);

        for(let spot of childParkingSpots) {
            await this.parkingSpotService.deleteParkingSpot(compound_id, spot.id);
        }

        const parking_compound = await this.prisma.parking_compound.delete({
            where: {
                id: id
            }
        });

        return {message: `Parking compound with id ${parking_compound.id} has been deleted!`}

    }

    async getCompound(compound_id: number) {
        const parking_compound = await this.prisma.parking_compound.findUnique(
            {
                where: {
                    id: compound_id
                }
            }
        );

        return parking_compound;
    }

    async getAllCompounds() {
        const parking_compounds = await this.prisma.parking_compound.findMany();
        return parking_compounds;
    }

    async getAllCompoundsByOwner(owner_id: number) {
        const parking_compounds = await this.prisma.parking_compound.findMany({
            where: {
                owner_id: owner_id
            }
        })

        return parking_compounds
    }
}