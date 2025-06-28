import 'package:test/test.dart';
import 'package:string_calculator_tdd/string_calculator_tdd.dart';

void main() {
  test('throws exception for numbers that are too big', () {
    expect(() => add('1,100000000000000000000000'), throwsA(isA<Exception>()));
    expect(() => add('999999999999999999999999'), throwsA(isA<Exception>()));
  });
  test('throws exception for input with special characters', () {
    expect(() => add('1,2,\$'), throwsA(isA<Exception>()));
    expect(() => add('1,2,@'), throwsA(isA<Exception>()));
    expect(() => add('1,2,3!'), throwsA(isA<Exception>()));
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
  test('throws exception for input with mixed valid and invalid numbers', () {
    expect(() => add('1,2,three,4'), throwsA(isA<Exception>()));
    expect(() => add('1,2,3.5'),
        throwsA(isA<Exception>())); // if only integers allowed
  });

  test('throws exception for input with negative and invalid numbers', () {
    expect(() => add('-1,abc'), throwsA(isA<Exception>()));
    expect(() => add('-1,-2,xyz'), throwsA(isA<Exception>()));
  });

  test('throws exception for input with only whitespace and invalid chars', () {
    expect(() => add('   abc   '), throwsA(isA<Exception>()));
    expect(() => add('\n @ \n'), throwsA(isA<Exception>()));
  });
}
