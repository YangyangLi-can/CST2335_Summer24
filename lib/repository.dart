import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Repository {
  final _secureStorage = const FlutterSecureStorage();

  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';
  String _email = '';

  String get firstName => _firstName;
  set firstName(String value) => _firstName = value;

  String get lastName => _lastName;
  set lastName(String value) => _lastName = value;

  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) => _phoneNumber = value;

  String get email => _email;
  set email(String value) => _email = value;

  Future<void> loadData() async {
    _firstName = await _secureStorage.read(key: 'firstName') ?? '';
    _lastName = await _secureStorage.read(key: 'lastName') ?? '';
    _phoneNumber = await _secureStorage.read(key: 'phoneNumber') ?? '';
    _email = await _secureStorage.read(key: 'email') ?? '';
  }

  Future<void> saveData() async {
    await _secureStorage.write(key: 'firstName', value: _firstName);
    await _secureStorage.write(key: 'lastName', value: _lastName);
    await _secureStorage.write(key: 'phoneNumber', value: _phoneNumber);
    await _secureStorage.write(key: 'email', value: _email);
  }
}