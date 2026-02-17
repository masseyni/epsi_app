import 'package:flutter/material.dart';
import '../services/qa_service.dart';

class QAScreen extends StatefulWidget {
  const QAScreen({super.key});

  @override
  _QAScreenState createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  final QAService _qaService = QAService();
  final TextEditingController _questionController = TextEditingController();
  final List<Map<String, String>> _questionHistory = [];
  String _answer = '';
  bool _isLoading = false;
  String? _error;

  final List<String> _suggestedQuestions = [
    "Quelles sont les spécialisations du Bachelor SIN ?",
    "Comment fonctionne l'alternance ?",
    "Quels sont les débouchés après l'EPSI ?",
    "Quelles sont les conditions d'admission ?",
    "Comment se déroule la vie étudiante ?",
    "Quels sont les équipements disponibles sur les campus ?",
  ];

  Future<void> _askQuestion() async {
    if (!_qaService.validateQuestion(_questionController.text)) {
      setState(() => _error = 'La question doit contenir entre 1 et 500 caractères');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _qaService.askQuestion(
        _questionController.text,
        'fr',
      );
      
      setState(() {
        _answer = response['answer'];
        _questionHistory.insert(0, {
          'question': _questionController.text,
          'answer': response['answer'],
          'timestamp': DateTime.now().toString(),
        });
        _questionController.clear();
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistant EPSI'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Suggestions de questions
                  if (_questionHistory.isEmpty) ...[
                    const Text(
                      'Questions suggérées',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _suggestedQuestions.map((question) {
                        return ActionChip(
                          label: Text(question),
                          onPressed: () {
                            _questionController.text = question;
                            _askQuestion();
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Historique des questions
                  ..._questionHistory.map((qa) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Question utilisateur
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              qa['question']!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        // Réponse bot
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              qa['answer']!,
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),

            // Zone de saisie
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _questionController,
                          decoration: const InputDecoration(
                            hintText: 'Posez votre question...',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: _askQuestion,
                              color: Theme.of(context).primaryColor,
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }
} 