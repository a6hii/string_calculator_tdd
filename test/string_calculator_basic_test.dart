import 'package:test/test.dart';
import '../lib/string_calculator_tdd.dart';

void main() {
  test('returns 0 for empty string', () => expect(add(''), 0));
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
  test('handles new lines as delimiters', () {
    expect(add('1\n2,3'), 6);
    expect(add('4\n5\n6'), 15);
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
  test('ignores numbers bigger than 1000', () {
    expect(add('2,1001'), 2);
    expect(add('1000,1'), 1001);
    expect(add('1234,1,1001,2'), 3);
  });
}
