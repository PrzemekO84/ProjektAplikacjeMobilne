import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/database_service.dart';

class AddFlashcardScreen extends StatefulWidget {
  final String? existingSetName;

  const AddFlashcardScreen({super.key, this.existingSetName});

  @override
  State<AddFlashcardScreen> createState() => _AddFlashcardScreenState();
}

class _AddFlashcardScreenState extends State<AddFlashcardScreen> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();
  final _setNameController = TextEditingController();
  final DatabaseService _dbService = DatabaseService();

  void _saveCard() async {
    final question = _questionController.text.trim();
    final answer = _answerController.text.trim();
    final setName = widget.existingSetName ?? _setNameController.text.trim();

    if (question.isEmpty || answer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wypełnij pytanie i odpowiedź')),
      );
      return;
    }

    final newCard = Flashcard(
      question: question,
      answer: answer,
      setName: setName.isEmpty ? 'Bez nazwy' : setName,
    );

    await _dbService.addFlashcard(newCard);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dodaj fiszkę')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            if (widget.existingSetName == null) ...[
              TextField(
                controller: _setNameController,
                decoration: const InputDecoration(labelText: 'Nazwa zestawu'),
              ),
              const SizedBox(height: 16),
            ],
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: 'Pytanie'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(labelText: 'Odpowiedź'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveCard,
              child: const Text('Zapisz fiszkę'),
            ),
          ],
        ),
      ),
    );
  }
}
