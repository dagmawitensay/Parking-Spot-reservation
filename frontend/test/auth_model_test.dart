import 'package:test/test.dart';
import 'package:frontend/auth/models/auth.dart';

void main() {
  group('User model tests', () {
    test('User should be initialized correctly', () {
      final user = User(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(user.id, isNull);
      expect(user.username, isNull);
      expect(user.email, 'test@example.com');
      expect(user.password, 'password123');
    });

    test('User.fromJson should create a User instance from JSON', () {
      final json = {
        'id': 1,
        'username': 'test_user',
        'email': 'test@example.com',
        'password': 'password123',
      };

      final user = User.fromJson(json);

      expect(user.id, 1);
      expect(user.username, 'test_user');
      expect(user.email, 'test@example.com');
      expect(user.password, 'password123');
    });
  });

  group('CompoundOwner model tests', () {
    test('CompoundOwner should be initialized correctly', () {
      final owner = CompoundOwner(
        username: 'owner_user',
        email: 'owner@example.com',
        password: 'password123',
        firstName: 'John',
        lastName: 'Doe',
      );

      expect(owner.id, isNull);
      expect(owner.username, 'owner_user');
      expect(owner.email, 'owner@example.com');
      expect(owner.password, 'password123');
      expect(owner.firstName, 'John');
      expect(owner.lastName, 'Doe');
    });

    test(
        'CompoundOwner.fromJson should create a CompoundOwner instance from JSON',
        () {
      final json = {
        'id': 1,
        'username': 'owner_user',
        'email': 'owner@example.com',
        'password': 'password123',
        'firstName': 'John',
        'lastName': 'Doe',
      };

      final owner = CompoundOwner.fromJson(json);

      expect(owner.id, 1);
      expect(owner.username, 'owner_user');
      expect(owner.email, 'owner@example.com');
      expect(owner.password, 'password123');
      expect(owner.firstName, 'John');
      expect(owner.lastName, 'Doe');
    });
  });

  group('SpotReservingUser model tests', () {
    test('SpotReservingUser should be initialized correctly', () {
      final user = SpotReservingUser(
        id: 1,
        username: 'spot_user',
        email: 'spot@example.com',
        password: 'password123',
        firstName: 'Jane',
        lastName: 'Smith',
      );

      expect(user.id, 1);
      expect(user.username, 'spot_user');
      expect(user.email, 'spot@example.com');
      expect(user.password, 'password123');
      expect(user.firstName, 'Jane');
      expect(user.lastName, 'Smith');
    });

    test(
        'SpotReservingUser.fromJson should create a SpotReservingUser instance from JSON',
        () {
      final json = {
        'id': 1,
        'username': 'spot_user',
        'email': 'spot@example.com',
        'password': 'password123',
        'firstName': 'Jane',
        'lastName': 'Smith',
      };

      final user = SpotReservingUser.fromJson(json);

      expect(user.id, 1);
      expect(user.username, 'spot_user');
      expect(user.email, 'spot@example.com');
      expect(user.password, 'password123');
      expect(user.firstName, 'Jane');
      expect(user.lastName, 'Smith');
    });
  });
}
