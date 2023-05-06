import { Test, TestingModule } from '@nestjs/testing';
import { ParkingSpotService } from './parking-spot.service';

describe('ParkingSpotService', () => {
  let service: ParkingSpotService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ParkingSpotService],
    }).compile();

    service = module.get<ParkingSpotService>(ParkingSpotService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
