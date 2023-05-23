import { Controller, Delete, Get, Param, ParseIntPipe, Post } from "@nestjs/common";
import { CustomerService } from "./customer.service";

@Controller('customers')
export class CustomerController {
    constructor(private customerService: CustomerService) {}
    // create a reservation for customer
    @Post(':cust_id/reservations')
    createReservation(@Param('cust_id', ParseIntPipe) cust_id: number) {
        
    }

    // Get all reservations for customer
    @Get(':cust_id/reservations')
    getAllReservations(@Param('cust_id', ParseIntPipe) cust_id: number) {

    }

    // Get specific reservation for customer
    @Get(':cust_id/reservations/:reservation_id')
    getReservation(@Param('cust_id', ParseIntPipe) cust_id: number, 
    @Param('reservation_id', ParseIntPipe) reservation_id: number
    ) {

    }

    // Delete  a reservation for customer
    @Delete(':cust_id/reservations/:reservation_id')
    deleteReservation(@Param('cust_id', ParseIntPipe) cust_id:number,
    @Param('reservation_id', ParseIntPipe) reservation_id: number) {

    }

}