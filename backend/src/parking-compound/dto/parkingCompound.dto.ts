import { IsNotEmpty, IsNumber } from "class-validator"

export class ParkingCompoundDto {
    id: number;

    @IsNotEmpty()
    Region: string;

    @IsNotEmpty()
    Zone: string

    @IsNotEmpty()
    Wereda: string

    @IsNotEmpty()
    Kebele: number

    @IsNotEmpty()
    @IsNumber()
    price: number;

    @IsNotEmpty()
    @IsNumber()
    available_spots: number;

    @IsNotEmpty()
    @IsNumber()
    total_spots: number
}