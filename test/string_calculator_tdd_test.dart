import 'package:test/test.dart';

void main() {
  test('returns 0 for empty string', () {
    expect(add(''), 0);
  });
  test('returns the number itself for a single number', () {
    expect(add('1'), 1);
    expect(add('42'), 42);
  });
  test('returns the sum for two comma-separated numbers', () {
    expect(add('1,2'), 3);
    expect(add('10,5'), 15);
  });
  test('returns the sum for multiple comma-separated numbers', () {
    expect(add('1,2,3,4'), 10);
    expect(add('5,5,5,5,5'), 25);
  });
  test('handles new lines as delimiters', () {
    expect(add('1\n2,3'), 6);
    expect(add('4\n5\n6'), 15);
  });
}
