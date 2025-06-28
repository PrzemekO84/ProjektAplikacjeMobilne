class Flashcard {
  final int? id;
  final String question;
  final String answer;
  final String? setName;

  Flashcard({
    this.id,
    required this.question,
    required this.answer,
    this.setName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'setName': setName,
    };
  }

  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
      id: map['id'],
      question: map['question'],
      answer: map['answer'],
      setName: map['setName'],
    );
  }
}
