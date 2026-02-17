import 'dart:async';

class QAService {
  final Map<String, String> knowledgeBase = {
    "alternance":
        "L’alternance à l’EPSI permet aux étudiants de combiner formation académique et expérience professionnelle en entreprise. Elle est accessible selon le niveau d’études.",
    "admission":
        "Les admissions à l’EPSI se font sur étude de dossier et entretien. Les modalités varient selon le programme (Bachelor, Master, etc.).",
    "debouches":
        "Les diplômés de l’EPSI deviennent développeurs, ingénieurs cloud, experts cybersécurité, data engineers ou chefs de projet IT.",
    "specialisations":
        "Le Bachelor EPSI propose des spécialisations en développement, cybersécurité, cloud computing et data.",
    "vie etudiante":
        "La vie étudiante à l’EPSI comprend des associations, des projets collaboratifs, des hackathons et des événements tech.",
    "campus":
        "Les campus EPSI disposent de salles informatiques modernes, espaces collaboratifs et équipements techniques avancés."
  };

  Future<Map<String, dynamic>> askQuestion(String question, String language) async {
    await Future.delayed(const Duration(seconds: 1));

    String lowerQuestion = question.toLowerCase();

    String bestMatch = knowledgeBase.entries.firstWhere(
      (entry) => lowerQuestion.contains(entry.key),
      orElse: () => const MapEntry("default", 
        "Je suis l'assistant EPSI. Pour plus d'informations détaillées, consultez le site officiel ou contactez l'administration."),
    ).value;

    return {
      "answer": bestMatch
    };
  }

  bool validateQuestion(String question) {
    return question.isNotEmpty && question.length <= 500;
  }
}
