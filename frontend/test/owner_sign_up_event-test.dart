import 'package:frontend/auth/bloc/events/owner_signup_event.dart';
import 'package:test/test.dart';
import 'package:frontend/auth/models/auth.dart';

void main() {
  group('CompoundOwnerSignUpEvent', () {
    test('OwnerSignUpLoad event should have empty props', () {
      final event = OwnerSignUpLoad();
      expect(event.props, isEmpty);
    });

    test('OwnerSignUpFormInitalizedEvent event should have empty props', () {
      final event = OwnerSignUpFormInitalizedEvent();
      expect(event.props, isEmpty);
    });

    test('OwnerSignUpButtonPressedEvent event should have empty props', () {
      final event = OwnerSignUpButtonPressedEvent();
      expect(event.props, isEmpty);
    });

    test('OwnerSignUpEmailChangedEvent event should have correct props', () {
      final email = 'test@example.com';
      final event = OwnerSignUpEmailChangedEvent(email);
      expect(event.props, [email]);
    });

    test('OwnerSignUpPasswordChangedEvent event should have correct props', () {
      final password = 'password123';
      final event = OwnerSignUpPasswordChangedEvent(password);
      expect(event.props, [password]);
    });

    test('OwnerSignUp event should have correct props', () {
      final owner = CompoundOwner(
          name: 'Ayat',
          email: 'test@example.com',
          firstName: 'nati',
          lastName: 'yimer',
          username: 'nati',
          password: '12345');
      final event = OwnerSignUp(owner: owner);
      expect(event.props, [owner]);
    });

    test('OwnerProfileUpdate event should have correct props', () {
      final owner = CompoundOwner(
          name: 'Ayat',
          email: 'test@example.com',
          firstName: 'nati',
          lastName: 'yimer',
          username: 'nati',
          password: '12345');
      final event = OwnerProfileUpdate(owner);
      expect(event.props, [owner]);
    });

    test('OwnerDelete event should have correct props', () {
      final ownerId = 1;
      final event = OwnerDelete(ownerId);
      expect(event.props, [ownerId]);
    });

    test('OwnerDelete event should have correct string representation', () {
      final ownerId = 1;
      final event = OwnerDelete(ownerId);
      expect(event.toString(), 'Owner Deleted {owner Id: $ownerId}');
    });
  });
}
