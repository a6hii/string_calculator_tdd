import 'package:test/test.dart';
import '../lib/string_calculator_tdd.dart';

void main() {
  test('supports custom single-character delimiter', () {
    expect(add('//;\n1;2'), 3);
    expect(add('//#\n2#3#4'), 9);
  });
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
