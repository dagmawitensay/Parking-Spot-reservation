import { Test, TestingModule } from '@nestjs/testing';
import { SpotUserService } from './spot-user.service';

describe('SpotUserService', () => {
  let service: SpotUserService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [SpotUserService],
    }).compile();

    service = module.get<SpotUserService>(SpotUserService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
