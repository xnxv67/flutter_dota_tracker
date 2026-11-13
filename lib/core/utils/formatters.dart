String formatPercent(double value) {
  return '${(value * 100).toStringAsFixed(1)}%';
}

String formatDuration(int seconds) {
  final minutes = seconds ~/ 60;
  final rest = seconds % 60;
  return '$minutes:${rest.toString().padLeft(2, '0')}';
}

String formatDate(int secondsSinceEpoch) {
  final date = DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day.$month.${date.year}';
}

String formatKda(int kills, int deaths, int assists) {
  return '$kills / $deaths / $assists';
}
