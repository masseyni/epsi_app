import 'dart:async';

class QAService {

  Future<Map<String, dynamic>> askQuestion(String question, String language) async {
    await Future.delayed(const Duration(seconds: 1)); // simulation délai

    String answer;

    final q = question.toLowerCase();

    if (q.contains("alternance")) {
      answer = "L'alternance à l'EPSI permet d'alterner entre formation académique et expérience en entreprise. Elle est accessible dès certaines années selon le programme.";
    } 
    else if (q.contains("admission")) {
      answer = "Les admissions se font sur dossier et entretien. Les modalités varient selon le niveau d'entrée (Bachelor, Master, etc.).";
    } 
    else if (q.contains("débou")) {
      answer = "Après l'EPSI, les étudiants peuvent devenir développeur, ingénieur cloud, expert cybersécurité, data engineer ou poursuivre en Master.";
    } 
    else if (q.contains("spécialisation")) {
      answer = "Le Bachelor propose plusieurs spécialisations comme développement, cybersécurité, cloud et data.";
    } 
    else {
      answer = "Merci pour votre question. Pour plus d'informations détaillées, veuillez consulter le site officiel de l'EPSI.";
    }

    return {
      "answer": answer
    };
  }

  bool validateQuestion(String question) {
    return question.isNotEmpty && question.length <= 500;
  }
}
