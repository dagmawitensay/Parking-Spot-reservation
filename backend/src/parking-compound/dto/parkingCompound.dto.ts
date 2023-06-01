import { IsInt, IsNotEmpty, IsNumber, IsString } from "class-validator"

export class ParkingCompoundDto {
    id: number;
    @IsString()
    @IsNotEmpty()
    
    name: string;
    @IsNotEmpty()
    @IsString()
    Region: string;

    @IsNotEmpty()
    @IsString()
    Zone: string

    @IsNotEmpty()
    @IsString()
    Wereda: string

    @IsNotEmpty()
    Kebele: string
    
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