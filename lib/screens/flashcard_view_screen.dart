import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardViewScreen extends StatefulWidget {
  final List<Flashcard> flashcards;

  const FlashcardViewScreen({super.key, required this.flashcards});

  @override
  State<FlashcardViewScreen> createState() => _FlashcardViewScreenState();
}

class _FlashcardViewScreenState extends State<FlashcardViewScreen> {
  int _currentIndex = 0;
  bool _showAnswer = false;

  void _nextCard() {
    setState(() {
      _showAnswer = false;
      _currentIndex++;
      if (_currentIndex >= widget.flashcards.length) {
        _currentIndex = 0;
      }
    });
  }

  void _previousCard() {
    setState(() {
      _showAnswer = false;
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.flashcards[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tryb nauki'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                card.question,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              if (_showAnswer)
                Text(
                  card.answer,
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                  textAlign: TextAlign.center,
                )
              else
                const Text(
                  '🔒 Odpowiedź ukryta',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showAnswer = true;
                  });
                },
                child: const Text('Pokaż odpowiedź'),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: _currentIndex > 0 ? _previousCard : null,
                    child: const Text('Poprzednia fiszka'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: _nextCard,
                    child: const Text('Następna fiszka'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
