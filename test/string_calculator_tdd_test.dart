import 'package:test/test.dart';

void main() {
  test('returns 0 for empty string', () {
    expect(add(''), 0);
  });
  test('returns the number itself for a single number', () {
    expect(add('1'), 1);
    expect(add('42'), 42);
  });
}
