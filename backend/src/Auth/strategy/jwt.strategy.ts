import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import {
  ExtractJwt,
  Strategy,
} from 'passport-jwt';
import { PrismaService } from '../../prisma/prisma.service';
import { JwtPayload } from './jwtPayload';

@Injectable()
export class JwtStrategy extends PassportStrategy(
  Strategy,
  'jwt',
) {
  constructor(
    config: ConfigService,
    private prisma: PrismaService,
  ) {
    super({
      jwtFromRequest:
        ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: config.get('JWT_SECRET'),
    });
  }

  // async validate(payload: {
  //   sub: number;
  //   email: string;
  //   role: string;
  // }) {
    // const user =
    //   await this.prisma.User.findUnique({
    //     where: {
    //       id: payload.sub
    //     },
    //   });
    // delete user.hash;
    validate(payload: JwtPayload) {
      // console.log(payload);
      return payload;
    }
  }

