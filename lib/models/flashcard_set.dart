class FlashcardSet {
  final int? id;
  final String name;

  FlashcardSet({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory FlashcardSet.fromMap(Map<String, dynamic> map) {
    return FlashcardSet(
      id: map['id'] as int?,
      name: map['name'] as String,
    );
  }
}
