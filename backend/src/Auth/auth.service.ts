import { ForbiddenException, Injectable } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import { PrismaService } from "src/prisma/prisma.service";
import * as argon from 'argon2';
import { AuthDto } from "./dto";
import { JwtService } from '@nestjs/jwt';
import { Dto } from "src/auth/common_dto";
import { compound_owner } from "@prisma/client";

@Injectable()
export class AuthService{
    constructor(
        private prisma: PrismaService,
        private jwt: JwtService,
        private config: ConfigService,
      ) {}
      
     
    
      async compoundOwnerSignup(dto: Dto) {
        // generate the password hash
        const hash = await argon.hash(dto.password);
        console.log(hash)
        // save the new user in the db
        try {
          const user = await this.prisma.User.create({
            data: {
              user_name: dto.first_name,
              hash: hash,
              email: dto.email,
              role : 'owner',
              compoundOwner :{
                create: {
                  first_name: dto.first_name,
                  last_name: dto.last_name,
                }
              }
            },
          });

        return this.signToken(user.id, user.email,user.role);
      
        } catch (error) {
            if (error.code === 'P2002') {
              throw new ForbiddenException(
                  'Credentials taken',
              );
            }

          console.log(error.code,error)
          throw error;
        }
      }
      cheking(){
        return 'authorized'
      }


      async spotUserSignup(dto: Dto) {
        // generate the password hash
        const hash = await argon.hash(dto.password);
        // save the new user in the db
        try {
          const user = await this.prisma.User.create({
            data: {
              user_name: dto.first_name,
              email: dto.email,
              hash: hash,
              role: 'reserver',
              spotUser :{
                create: {
                  first_name: dto.first_name,
                  last_name: dto.last_name,
                }
              }            
              
            },
          });
        console.log(user.email)
        return this.signToken(user.id, user.email, user.role);
      
        } catch (error) {
            if (error.code === 'P2002') {
              throw new ForbiddenException(
                  'Credentials taken',
              );
            }
          console.log(error.code,error)
          throw error;
        }
      }
       
      async Signin(dto:AuthDto){
        console.log(dto," signin dto");
        const user = await this.prisma.User.findUnique({
          where: {
            email: dto.email
          }
        })
        console.log(user);
        if (!user){
          throw new ForbiddenException("Incorrect Email")
        }
      const user_password = await argon.hash(dto.password)
      const paswMatches = argon.verify(user_password,user.hash)   

      if(!paswMatches){
        throw new ForbiddenException("Incorrect password")
      }
      // delete user.password
      // return user
      // const { password: _, ...userWithoutPassword } = user;

      return this.signToken(user.id, user.email,user.role);
      }


async signToken(
    userId: number,
    email: string,
    role: string
  ): Promise<{ access_token: string, role: string}> {
    const payload = {
      sub: userId,
      email,
      role:role
    };
    const secret = this.config.get('JWT_SECRET');
    const token = await this.jwt.signAsync(
      payload,
      {
        expiresIn: '43200m',
        secret: secret,
      },
    );
    return {
      access_token: token,
      role: role
    };
  }
}

