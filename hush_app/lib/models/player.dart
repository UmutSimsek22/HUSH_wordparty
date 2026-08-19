class Player {
  final String id;
  String name;
  final String teamId;

  int correctCount;
  int hushCount;
  int passCount;

  Player({
    required this.id,
    required this.name,
    required this.teamId,
    this.correctCount = 0,
    this.hushCount = 0,
    this.passCount = 0,
  });

  int get netPoints => correctCount - hushCount;

  int get totalAttempts => correctCount + hushCount + passCount;

  double get accuracyRate {
    if (totalAttempts == 0) return 0.0;
    return (correctCount / totalAttempts) * 100.0;
  }

  void resetScore() {
    correctCount = 0;
    hushCount = 0;
    passCount = 0;
  }
}
