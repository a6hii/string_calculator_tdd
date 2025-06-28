int add(String numbers) {
  if (numbers.trim().isEmpty) return 0;

  final parts = numbers.split(',');
  int sum = 0;
  for (var part in parts) {
    final value = int.tryParse(part.trim());
    if (value != null) {
      sum += value;
    }
  }
  return sum;
}
