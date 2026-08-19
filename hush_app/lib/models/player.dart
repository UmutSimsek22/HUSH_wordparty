class Player {
  final String id;
  String name;
  final String teamId;

  int correctCount;
  int tabooCount;
  int passCount;

  Player({
    required this.id,
    required this.name,
    required this.teamId,
    this.correctCount = 0,
    this.tabooCount = 0,
    this.passCount = 0,
  });

  int get netPoints => correctCount - tabooCount;

  int get totalAttempts => correctCount + tabooCount + passCount;

  double get accuracyRate {
    if (totalAttempts == 0) return 0.0;
    return (correctCount / totalAttempts) * 100.0;
  }

  void resetScore() {
    correctCount = 0;
    tabooCount = 0;
    passCount = 0;
  }
}
