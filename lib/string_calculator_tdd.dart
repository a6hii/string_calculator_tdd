int add(String numbers) {
  if (numbers.trim().isEmpty) return 0;

  String input = numbers.trim();
  List<String> delimiters = [',', '\n'];

  // Handle custom delimiters
  if (input.startsWith('//')) {
    final newlineIndex = input.indexOf('\n');
    final separatorLine = input.substring(2, newlineIndex);
    input = input.substring(newlineIndex + 1);

    final delimiterMatches = RegExp(r'\[(.*?)\]').allMatches(separatorLine);
    if (delimiterMatches.isNotEmpty) {
      delimiters =
          delimiterMatches.map((m) => RegExp.escape(m.group(1)!)).toList();
    } else {
      delimiters = [RegExp.escape(separatorLine)];
    }
  }

  final delimiterRegex = RegExp(delimiters.join('|'));
  final parts = input.split(delimiterRegex);

  List<int> numbersList = [];
  List<int> negativeNumbers = [];

  for (var part in parts) {
    part = part.trim();
    if (part.isEmpty) continue;
    final value = int.tryParse(part);
    if (value == null) throw Exception('Invalid number: $part');
    if (value < 0) negativeNumbers.add(value);
    if (value > 1000000000) throw Exception('Number too big: $value');
    if (value <= 1000) numbersList.add(value);
  }

  if (negativeNumbers.isNotEmpty) {
    throw Exception(
        'negative numbers not allowed ${negativeNumbers.join(',')}');
  }

  return numbersList.fold(0, (sum, n) => sum + n);
}
