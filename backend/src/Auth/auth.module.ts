import { Module } from "@nestjs/common";
import { AuthController } from "./auth.controller";
import { AuthService } from "./auth.service";
import { JwtModule } from "@nestjs/jwt";
import { JwtStrategy } from './strategy';
// import { Strategy as JwtStrategy, ExtractJwt } from 'passport-jwt';



@Module({
  imports: [JwtModule.register({
    secret:'JWT_SECRET'
  })],
  controllers: [AuthController],
  providers: [AuthService,JwtStrategy],
})

export class AuthModule{}