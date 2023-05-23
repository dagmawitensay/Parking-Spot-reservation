import { Injectable } from "@nestjs/common";
import { PrismaClient } from "@prisma/client";

@Injectable()
export class PrismaService extends PrismaClient {
    constructor() {
        super({
            datasources: {
            db: {
                url: "mysql://root:123@localhost:3306/parking_spot?schema=public"
            }
        }
        })
    }
}