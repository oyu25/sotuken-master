import 'dart:convert' show json;
import 'package:flutter/services.dart';
import 'question.dart';

class ApiService {
  static Future<List<Question>> fetchQuestions(String fileName, int maxQuestions) async {
    try {
      final String jsonString = await rootBundle.loadString('assets/$fileName');
      final List<dynamic> jsonList = json.decode(jsonString);

      // Shuffle the questions
      jsonList.shuffle();

      // Take only the first maxQuestions
      final List<Question> questions = jsonList
          .take(maxQuestions)
          .map((json) => Question.fromJson(json))
          .toList();

      return questions;
    } catch (e) {
      print('Error decoding JSON: $e');
      return [];
    }
  }
}
