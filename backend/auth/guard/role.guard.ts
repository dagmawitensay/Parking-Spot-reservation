// import { User } from "@prisma/client";
import { CanActivate, ExecutionContext, Injectable } from "@nestjs/common";
import { Reflector } from "@nestjs/core";
import { Observable } from "rxjs";
import { JwtService } from "@nestjs/jwt";
import { Role } from "../decorator/role.enum";
import { Roles } from '../decorator/roles.decorator';
import { AuthGuard } from "@nestjs/passport";

@Injectable()
export class RolesGuard  implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext):boolean | Promise<boolean> | Observable<boolean>{

    const requiredRoles = this.reflector.getAllAndOverride<Role[]>('roles',[
        context.getHandler(),
        context.getClass(),
    ]);
    console.log(requiredRoles)
    if (!requiredRoles) {
      return true; 
    }
 
    const request = context.switchToHttp().getRequest();
    let user = request.user
    const permission = requiredRoles.some((role) => user.role === role)
    return permission;   
  }
}  



