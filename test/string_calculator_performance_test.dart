import 'package:test/test.dart';
import 'package:string_calculator_tdd/string_calculator_tdd.dart';

void main() {
  test('add handles very large input quickly', () {
    final numbers = List.generate(100000, (i) => '1').join(',');
    final stopwatch = Stopwatch()..start();
    final result = add(numbers);
    stopwatch.stop();
    expect(result, 100000);
    //Should take less than 1 second
    expect(stopwatch.elapsedMilliseconds < 1000, isTrue, reason: 'Too slow!');
  });

  test('add handles very large input with newlines', () {
    final numbers = List.generate(100000, (i) => '1').join('\n');
    final stopwatch = Stopwatch()..start();
    final result = add(numbers);
    stopwatch.stop();
    expect(result, 100000);
    expect(stopwatch.elapsedMilliseconds < 1000, isTrue, reason: 'Too slow!');
  });

  test('add handles very large input with mixed delimiters', () {
    final numbers =
        '${List.generate(50000, (i) => '1').join(',')},${List.generate(50000, (i) => '1').join('\n')}';
    final stopwatch = Stopwatch()..start();
    final result = add(numbers);
    stopwatch.stop();
    expect(result, 100000);
    //Should take less than 1.5 second
    expect(stopwatch.elapsedMilliseconds < 1500, isTrue, reason: 'Too slow!');
  });

  test('add handles very large input with custom delimiter', () {
    final numbers = List.generate(100000, (i) => '1').join('***');
    final input = '//[***]\n$numbers';
    final stopwatch = Stopwatch()..start();
    final result = add(input);
    stopwatch.stop();
    expect(result, 100000);
    expect(stopwatch.elapsedMilliseconds < 1500, isTrue, reason: 'Too slow!');
  });
}
