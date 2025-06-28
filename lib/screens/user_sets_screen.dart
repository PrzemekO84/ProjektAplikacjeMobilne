import 'package:flutter/material.dart';
import '../models/flashcard_set.dart';
import '../services/database_service.dart';
import 'set_shell_screen.dart';

class UserSetsScreen extends StatefulWidget {
  const UserSetsScreen({super.key});

  @override
  State<UserSetsScreen> createState() => _UserSetsScreenState();
}

class _UserSetsScreenState extends State<UserSetsScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<FlashcardSet> _sets = [];

  @override
  void initState() {
    super.initState();
    _loadSets();
  }

  Future<void> _loadSets() async {
    final sets = await _dbService.getFlashcardSets();
    setState(() {
      _sets = sets;
    });
  }

  Future<void> _addSet(String name) async {
    final existingSets = await _dbService.getFlashcardSets();

    if (existingSets.length >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Możesz mieć maksymalnie 10 zestawów')),
      );
      return;
    }

    final alreadyExists = existingSets.any((set) => set.name == name);
    if (alreadyExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Zestaw o tej nazwie już istnieje')),
      );
      return;
    }

    await _dbService.createFlashcardSet(name);
    _loadSets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Twoje zestawy")),
      body: _sets.isEmpty
          ? const Center(child: Text("Brak zestawów."))
          : ListView.builder(
        itemCount: _sets.length,
        itemBuilder: (context, index) {
          final entry = _sets[index];
          return ListTile(
            title: Text(entry.name),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Usuń zestaw"),
                    content: const Text("Czy na pewno chcesz usunąć ten zestaw wraz z jego fiszkami?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Anuluj"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Usuń"),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await _dbService.deleteFlashcardSet(entry.name);
                  _loadSets();
                }
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SetShellScreen(setName: entry.name),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              final controller = TextEditingController();
              return AlertDialog(
                title: const Text("Nowy zestaw"),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: "Nazwa zestawu"),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Anuluj"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final name = controller.text.trim();
                      if (name.isNotEmpty) {
                        Navigator.pop(context);
                        _addSet(name);
                      }
                    },
                    child: const Text("Dodaj"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
