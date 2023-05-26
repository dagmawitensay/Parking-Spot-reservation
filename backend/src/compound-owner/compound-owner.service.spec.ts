import { Test, TestingModule } from '@nestjs/testing';
import { CompoundOwnerService } from './compound-owner.service';

describe('CompoundOwnerService', () => {
  let service: CompoundOwnerService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [CompoundOwnerService],
    }).compile();

    service = module.get<CompoundOwnerService>(CompoundOwnerService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
