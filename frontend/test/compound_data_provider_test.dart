import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/compound/data/compound_data_provider.dart';
import 'package:frontend/compound/models/compound.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late CompoundDataProvider compoundDataProvider;
  late MockFlutterSecureStorage mockSecureStorage;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    mockHttpClient = MockHttpClient();
    compoundDataProvider = CompoundDataProvider();
    compoundDataProvider.storage = mockSecureStorage;
    compoundDataProvider.httpClient = mockHttpClient;
  });

  group('CompoundDataProvider', () {
    test('createCompound returns a Compound object on success', () async {
      final compound = Compound(
        id: 1,
        name: 'Compound 1',
        Region: 'Region 1',
        Wereda: 'Wereda 1',
        Zone: 'Zone 1',
        Kebele: 'Kebele 1',
        SlotPricePerHour: 10,
        availableSpots: 5,
        totalSpots: 10,
        ownerId: 1,
      );
      const token = 'token';
      final response = http.Response(
        '{"id":1,"name":"Compound 1","Region":"Region 1","Wereda":"Wereda 1","Zone":"Zone 1","Kebele":"Kebele 1","SlotPricePerHour":10,"availableSpots":5,"totalSpots":10,"ownerId":1}',
        201,
      );
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => token);
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => response);

      final result = await compoundDataProvider.createCompound(compound);

      expect(result, equals(compound));
      verify(() => mockSecureStorage.read(key: 'token')).called(1);
      verify(() => mockHttpClient.post(
            Uri.parse('http://localhost:3000/parking-compounds'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: any(named: 'body'),
          )).called(1);
    });

    test('createCompound throws an exception on failure', () async {
      final compound = Compound(
        id: 1,
        name: 'Compound 1',
        Region: 'Region 1',
        Wereda: 'Wereda 1',
        Zone: 'Zone 1',
        Kebele: 'Kebele 1',
        SlotPricePerHour: 10,
        availableSpots: 5,
        totalSpots: 10,
        ownerId: 1,
      );
      const token = 'token';
      final response = http.Response('Error', 400);
      when(() => mockSecureStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => token);
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => response);

      expect(
        () => compoundDataProvider.createCompound(compound),
        throwsA(isA<Exception>()),
      );
      verify(() => mockSecureStorage.read(key: 'token')).called(1);
      verify(() => mockHttpClient.post(
            Uri.parse('http://localhost:3000/parking-compounds'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: any(named: 'body'),
          )).called(1);
    });

    // Add more test cases for other methods in CompoundDataProvider
  });
}
