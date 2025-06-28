import 'flashcard.dart';

class FlashcardSet {
  final String title;
  final List<Flashcard> cards;

  FlashcardSet({required this.title, required this.cards});
}

final exampleSets = [
  FlashcardSet(
    title: 'Stolice Europy',
    cards: [
      Flashcard(question: 'Polska', answer: 'Warszawa'),
      Flashcard(question: 'Niemcy', answer: 'Berlin'),
      Flashcard(question: 'Francja', answer: 'Paryż'),
      Flashcard(question: 'Włochy', answer: 'Rzym'),
      Flashcard(question: 'Hiszpania', answer: 'Madryt'),
      Flashcard(question: 'Portugalia', answer: 'Lizbona'),
      Flashcard(question: 'Czechy', answer: 'Praga'),
      Flashcard(question: 'Szwecja', answer: 'Sztokholm'),
      Flashcard(question: 'Norwegia', answer: 'Oslo'),
      Flashcard(question: 'Austria', answer: 'Wiedeń'),
    ],
  ),
  FlashcardSet(
    title: 'Kraj – Kontynent',
    cards: [
      Flashcard(question: 'Brazylia', answer: 'Ameryka Południowa'),
      Flashcard(question: 'Chiny', answer: 'Azja'),
      Flashcard(question: 'Kanada', answer: 'Ameryka Północna'),
      Flashcard(question: 'Egipt', answer: 'Afryka'),
      Flashcard(question: 'Hiszpania', answer: 'Europa'),
      Flashcard(question: 'Australia', answer: 'Australia'),
      Flashcard(question: 'Nigeria', answer: 'Afryka'),
      Flashcard(question: 'Indie', answer: 'Azja'),
      Flashcard(question: 'Francja', answer: 'Europa'),
      Flashcard(question: 'USA', answer: 'Ameryka Północna'),
    ],
  ),
  FlashcardSet(
    title: 'Stolice Azji',
    cards: [
      Flashcard(question: 'Chiny', answer: 'Pekin'),
      Flashcard(question: 'Japonia', answer: 'Tokio'),
      Flashcard(question: 'Indie', answer: 'Nowe Delhi'),
      Flashcard(question: 'Arabia Saudyjska', answer: 'Rijad'),
      Flashcard(question: 'Iran', answer: 'Teheran'),
      Flashcard(question: 'Tajlandia', answer: 'Bangkok'),
      Flashcard(question: 'Wietnam', answer: 'Hanoi'),
      Flashcard(question: 'Malezja', answer: 'Kuala Lumpur'),
      Flashcard(question: 'Indonezja', answer: 'Dżakarta'),
      Flashcard(question: 'Korea Południowa', answer: 'Seul'),
    ],
  ),
];
