import 'package:test/test.dart';

void main() {
  // Basic cases
  test('returns 0 for empty string', () {
    expect(add(''), 0);
  });

  test('returns 0 for whitespace only', () {
    expect(add('   '), 0);
    expect(add('\n  ,  \n'), 0);
  });

  test('returns 0 for a very long string of only delimiters', () {
    expect(add(',' * 1000), 0);
    expect(add('\n' * 1000), 0);
  });

  test('returns 0 for string with only delimiters', () {
    expect(add(','), 0);
    expect(add('\n'), 0);
    expect(add(',\n,'), 0);
  });

  // Single and multiple numbers
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

  test('returns the sum for an unknown amount of numbers', () {
    expect(add('1,2,3,4,5,6,7,8,9,10'), 55);
    expect(add('10,20,30,40,50,60,70,80,90,100'), 550);
    expect(add(List.generate(100, (i) => '${i + 1}').join(',')), 5050);
  });

  // Delimiters and formatting
  test('handles new lines as delimiters', () {
    expect(add('1\n2,3'), 6);
    expect(add('4\n5\n6'), 15);
  });

  test('supports custom single-character delimiter', () {
    expect(add('//;\n1;2'), 3);
    expect(add('//#\n2#3#4'), 9);
  });

  test('ignores empty values between delimiters', () {
    expect(add('1,,2'), 3);
    expect(add('1,\n,2'), 3);
  });

  test('handles input with spaces', () {
    expect(add(' 1, 2 '), 3);
    expect(add('1 ,2, 3'), 6);
  });

  test('handles input with leading and trailing delimiters', () {
    expect(add(',1,2,'), 3);
    expect(add('\n1\n2\n'), 3);
  });

  // Special rules
  test('ignores numbers bigger than 1000', () {
    expect(add('2,1001'), 2);
    expect(add('1000,1'), 1001); // 1000 should be included
    expect(add('1234,1,1001,2'), 3);
  });

  // Error handling
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

  // Custom delimiter tests
  test('supports custom delimiter of any length', () {
    expect(add('//[***]\n1***2***3'), 6);
    expect(add('//[abcd]\n4abcd5abcd6'), 15);
  });

  test('supports custom delimiter containing numbers', () {
    expect(add('//[delim1]\n1delim12delim13'), 6);
  });

  test('supports custom delimiter with regex special characters', () {
    expect(add('//[.*?]\n1.*?2.*?3'), 6);
    expect(add('//[+]\n1+2+3'), 6);
  });

  // Multiple custom delimiters
  test('supports multiple custom delimiters', () {
    expect(add('//[*][%]\n1*2%3'), 6);
    expect(add('//[;][!]\n2;3!4'), 9);
  });

  test('supports multiple custom delimiters with length > 1', () {
    expect(add('//[***][%%]\n1***2%%3'), 6);
    expect(add('//[abc][def]\n1abc2def3'), 6);
    expect(add('//[longdelim][!!]\n5longdelim5!!5'), 15);
  });

  test('supports multiple custom delimiters with special characters', () {
    expect(add('//[.*][%]\n1.*2%3'), 6);
    expect(add('//[+][?]\n1+2?3'), 6);
  });

  // Edge cases for delimiters
  test('returns 0 for only custom delimiters and no numbers', () {
    expect(add('//[***]\n***'), 0);
    expect(add('//[abc][def]\nabc'), 0);
  });

  test('returns 0 for input with only delimiters and whitespace', () {
    expect(add(' , \n , '), 0);
  });

  test('handles mixed delimiters and whitespace', () {
    expect(add(' 1 ,\n2 , 3 '), 6);
  });
}
