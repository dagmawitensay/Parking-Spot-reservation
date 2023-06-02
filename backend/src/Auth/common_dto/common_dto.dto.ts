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
<<<<<<< HEAD
    
    // @IsNotEmpty()
    // phone_no:string;
=======
>>>>>>> 1d802ade27bb303a1fdbadf33eec1c124f59a3c5

    @IsString()
    @IsNotEmpty()
    password:string;

}


   
