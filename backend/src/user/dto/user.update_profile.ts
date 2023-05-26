import { IsString } from "class-validator";

export class UpdateProfile{

    @IsString()
    first_name: string;
    
    @IsString()
    last_name: string;

    @IsString()
    phone_no: string;

    @IsString()
    password: string;

}