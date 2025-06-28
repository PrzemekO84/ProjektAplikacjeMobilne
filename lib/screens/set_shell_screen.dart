import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/database_service.dart';
import 'add_flashcard_screen.dart';
import 'flashcard_view_screen.dart';

class SetShellScreen extends StatefulWidget {
  final String setName;

  const SetShellScreen({super.key, required this.setName});

  @override
  State<SetShellScreen> createState() => _SetShellScreenState();
}

class _SetShellScreenState extends State<SetShellScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<Flashcard> _flashcards = [];

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

  Future<void> _loadFlashcards() async {
    final cards = await _dbService.getFlashcardsBySet(widget.setName);
    setState(() {
      _flashcards = cards;
    });
  }

  void _startLearning() {
    if (_flashcards.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FlashcardViewScreen(flashcards: _flashcards),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zestaw: ${widget.setName}'),
        actions: [
          if (_flashcards.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.school),
              tooltip: 'Tryb nauki',
              onPressed: _startLearning,
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _flashcards.isEmpty
                ? const Center(child: Text("Brak fiszek w zestawie."))
                : ListView.builder(
              itemCount: _flashcards.length,
              itemBuilder: (context, index) {
                final card = _flashcards[index];
                return ListTile(
                  title: Text(card.question),
                  subtitle: Text(card.answer),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await _dbService.deleteFlashcard(card.id!);
                      _loadFlashcards();
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text("Rozpocznij naukę"),
              onPressed: _flashcards.isEmpty ? null : _startLearning,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AddFlashcardScreen(existingSetName: widget.setName),
            ),
          );
          if (result == true) {
            _loadFlashcards();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
