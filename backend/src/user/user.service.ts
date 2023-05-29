import { Injectable } from '@nestjs/common';
import {UpdateProfile} from './dto/user.update_profile';
import { AuthDto } from 'src/auth/dto';
import { PrismaService } from 'src/prisma/prisma.service';
import * as argon from 'argon2';

// @Injectable()
// export class UserService {
//     constructor( private prisma: PrismaService ){}
//     async update_profile(dto: UpdateProfile,dto2: AuthDto){
//         const hash  = await argon.hash(dto.password)
//         const my_data = await this.prisma.User.update({
//             where: {
//                 email: dto2.email 
//             },
//             data:{
//                 hash: hash,
//                 compound_owner:{
//                 update:{
//                     first_name: dto.first_name,
//                     last_name: dto.last_name,
//                     phone_no: dto.phone_no
//                 }
//             }
//             }
//         });
//         return my_data

//     }

// }

// user.service.ts


@Injectable()
export class UserService {
  constructor(private prismaService: PrismaService) {}

  async updateUserProfile(userId: number, updateDto: UpdateProfile): Promise<any> {
    // Get the existing user profile from the database
    const hash  = await argon.hash(updateDto.password)
    const userProfile = await this.prismaService.User.findUnique({
      where: { 
        id : userId 
         }
        });
   console.log(userProfile.role)
        const owner = 'owner'
        if (userProfile.role === owner){
          this.prismaService.User.update({
            data:{
                hash:hash,
                compoundOwner:{
                update:{
                    first_name: updateDto.first_name,
                    last_name: updateDto.last_name,
                    phone_no: updateDto.phone_no
                }
            }
        }
          });
        } else if (userProfile.role === 'reserver'){
            this.prismaService.User.update({
                data:{
                   hash: hash,
                    spotUser:{
                    update:{
                        first_name: updateDto.first_name,
                        last_name: updateDto.last_name,
                        phone_no: updateDto.phone_no
                    }
                }
            }
        });
        }
    
    return this.prismaService.spot_user.findUnique({
        where: {
            user_id: userId
        }
    });
    
  }
  async deleteAccount(userId:number): Promise<any>{
    const data = await this.prismaService.User.findUnique({
      where: {
        id: userId
      },
    });
    console.log(data)
    if (data.role === 'owner'){
      await this.prismaService.compound_owner.delete({
        where:{
          user_id : userId
        }
      });

      await this.prismaService.User.delete({
        where: {
            id: userId
        },
      });

    
    } else if (data.role === 'reserver'){
      await this.prismaService.spot_user.delete({
        where:{
          user_id: userId
        }
      });
      await this.prismaService.User.delete({
        where: {
            id: userId
        },
      });
    };

    
  }
}

