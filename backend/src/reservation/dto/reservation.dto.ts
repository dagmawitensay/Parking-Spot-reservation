import { IsNotEmpty } from "class-validator";

export class ReservationDto {
    @IsNotEmpty()
    start_time: Date;

    @IsNotEmpty()
    end_time: Date

}