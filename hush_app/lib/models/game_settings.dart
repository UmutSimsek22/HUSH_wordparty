class GameSettings {
  int timePerTurnSeconds;
  int numberOfRounds;
  int? passLimit; // null means unlimited passes
  bool isSoundEnabled;
  bool isVibrationEnabled;

  GameSettings({
    this.timePerTurnSeconds = 60,
    this.numberOfRounds = 2,
    this.passLimit = 3,
    this.isSoundEnabled = true,
    this.isVibrationEnabled = true,
  });

  bool get isUnlimitedPass => passLimit == null;

  GameSettings copyWith({
    int? timePerTurnSeconds,
    int? numberOfRounds,
    int? passLimit,
    bool? isSoundEnabled,
    bool? isVibrationEnabled,
  }) {
    return GameSettings(
      timePerTurnSeconds: timePerTurnSeconds ?? this.timePerTurnSeconds,
      numberOfRounds: numberOfRounds ?? this.numberOfRounds,
      passLimit: passLimit != null ? passLimit : this.passLimit,
      isSoundEnabled: isSoundEnabled ?? this.isSoundEnabled,
      isVibrationEnabled: isVibrationEnabled ?? this.isVibrationEnabled,
    );
  }
}
