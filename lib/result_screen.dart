import 'package:flutter/material.dart';
import 'question.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;
  final List<bool?> userAnswers;
  final List<bool?> userChoices;
  final VoidCallback retryQuiz;
  final VoidCallback goToHome;

  ResultScreen({
    required this.questions,
    required this.userAnswers,
    required this.userChoices,
    required this.retryQuiz,
    required this.goToHome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('結果発表'),
        leadingWidth: 85,  //leadingWidthを設定する
        leading: TextButton(
          child: Text(
            '戻る',
            style: TextStyle(
              color: Colors.white,  //文字の色を白にする
              fontWeight: FontWeight.bold,  //文字を太字する
              fontSize: 12.0,  //文字のサイズを調整する
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '結果',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  Question question = questions[index];
                  bool? userAnswer = userAnswers[index];
                  bool? userChoice = userChoices[index];
                  bool isCorrect = question.answer == userAnswer;

                  return GestureDetector(
                    onTap: () {
                      _showExplanationDialog(context, question);
                    },
                    child: Card(
                      color: isCorrect ? Colors.green[100] : Colors.red[100],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '問${index + 1}: ${question.text}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '正解: ${question.answer ? '〇' : '☓'}',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              'あなたの回答: ${userAnswer == true ? '〇' : '☓'}',
                              style: TextStyle(
                                color: isCorrect ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: retryQuiz,
                  child: Text('もう一回'),
                ),
                ElevatedButton(
                  onPressed: goToHome,
                  child: Text('選択ページに戻る'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showExplanationDialog(BuildContext context, Question question) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('解説'),
          content: Text(question.explanation),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('閉じる'),
            ),
          ],
        );
      },
    );
  }
}
