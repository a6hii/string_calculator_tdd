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
  test('supports custom single-character delimiter', () {
    expect(add('//;\n1;2'), 3);
    expect(add('//#\n2#3#4'), 9);
  });
  test('throws exception for negative numbers', () {
    expect(
        () => add('1,-2,3'),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString().contains('negative numbers not allowed -2'))));
  });
  test('shows all negative numbers in exception message', () {
    expect(
        () => add('-1,-2,3'),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString().contains('negative numbers not allowed -1,-2'))));
  });
  test('throws exception for completely invalid string', () {
    expect(() => add('abc'), throwsA(isA<Exception>()));
    expect(() => add('1,2,three'), throwsA(isA<Exception>()));
  });
  test('returns 0 for whitespace only', () {
    expect(add('   '), 0);
    expect(add('\n  ,  \n'), 0);
  });
}
