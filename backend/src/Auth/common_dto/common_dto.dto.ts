import {IsEmail, IsEmpty, IsNotEmpty, IsString} from  'class-validator';
export class Dto{
    
    @IsNotEmpty()
    first_name: string;
    
    @IsNotEmpty()
    last_name: string;
    
    @IsString()
    @IsEmail()
    @IsNotEmpty()
    email:string;

    // @IsString()
    // role:string;

    @IsString()
    @IsNotEmpty()
    password:string;

}


   
