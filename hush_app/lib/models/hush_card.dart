class HushCard {
  final int id;
  final String targetWord;
  final List<String> forbiddenWords;

  const HushCard({
    required this.id,
    required this.targetWord,
    required this.forbiddenWords,
  });

  factory HushCard.fromJson(Map<String, dynamic> json) {
    return HushCard(
      id: json['id'] as int,
      targetWord: json['targetWord'] as String,
      forbiddenWords: List<String>.from(json['forbiddenWords'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'targetWord': targetWord,
      'forbiddenWords': forbiddenWords,
    };
  }
}
