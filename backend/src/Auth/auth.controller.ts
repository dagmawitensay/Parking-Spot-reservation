import { Body, Controller, Post, UseGuards, Request, Get } from "@nestjs/common";
import { AuthService } from "./auth.service";
import { AuthDto } from "./dto";
import { Dto } from "src/auth/common_dto";
import { Roles } from "./decorator/roles.decorator";
import { Role } from "./decorator/role.enum";
import { RolesGuard } from "./guard/role.guard";
import { JwtGuard } from "./guard";


@Controller('auth')
export class AuthController{
    constructor(private authservice:AuthService){}

    @Post('owner/signup')
    signup(@Body() dto:Dto){
        return this.authservice.compoundOwnerSignup(dto);
    }

    @Post('parker/signup')
    Parker_signup(@Body() dto:Dto){
        return this.authservice.spotUserSignup(dto);
    }
    
    @Post('signin')
    signin(@Body() dto: AuthDto){
        return this.authservice.Signin(dto);
    }
    @Roles(Role.reserver)
    @UseGuards(JwtGuard, RolesGuard)
    @Get('check')
    for_checking(){
        return this.authservice.cheking()
    }
}