import { Body, Controller, Patch, UseGuards, Request, Param, Delete } from '@nestjs/common';
import { UserService } from './user.service';
import { AuthDto } from 'src/Auth/dto';
import { Dto } from 'src/auth/common_dto';
import { UpdateProfile } from './dto';
import { JwtGuard } from 'src/auth/guard';

@Controller('user')
export class UserController {
    constructor(private userservice: UserService){}

    // @Patch('user/profile')
    // update_profile(@Body() dto:UpdateProfile, dto2:Dto){
    //     this.usersevice.update_profile(dto,dto2)
    // }
    @Patch(':userId')
    @UseGuards(JwtGuard)
    async updateProfile(@Param('userId') userId:string, @Body() updateDto: UpdateProfile): Promise<any> {
    //   const Id = parseInt(userId);
      console.log(userId)
      const updatedProfile = await this.userservice.updateUserProfile(parseInt(userId), updateDto);
    //   delete updatedProfile.hash
      return updatedProfile;
    }

    @Delete(':userId')
    async deleteAccount(@Param('userId') userId:string){
        await this.userservice.deleteAccount(parseInt(userId))
    }
}
