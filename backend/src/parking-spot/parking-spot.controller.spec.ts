import { Test, TestingModule } from '@nestjs/testing';
import { ParkingSpotController } from './parking-spot.controller';

describe('ParkingSpotController', () => {
  let controller: ParkingSpotController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ParkingSpotController],
    }).compile();

    controller = module.get<ParkingSpotController>(ParkingSpotController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
