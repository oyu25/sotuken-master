import 'package:flutter/material.dart';
import 'quiz_page.dart';

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('選択ページ'),
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
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          CustomButton(
            onPressed: () => navigateToQuizPage(context, 'あ～お', 'Quiz.json', 10),
            buttonName: 'あ～お',
          ),
          CustomButton(
            onPressed: () => navigateToQuizPage(context, 'か～こ', 'Quiz1.json', 10),
            buttonName: 'か～こ',
          ),
          CustomButton(
            onPressed: () => navigateToQuizPage(context, 'さ～そ', 'Quiz2.json', 10),
            buttonName: 'さ～そ',
          ),
          CustomButton(
            onPressed: () => navigateToQuizPage(context, 'た～と', 'Quiz3.json', 10),
            buttonName: 'た～と',
          ),
          CustomButton(
            onPressed: () => navigateToQuizPage(context, 'な～の', 'Quiz4.json', 10),
            buttonName: 'な～の',
          ),
          CustomButton(
            onPressed: () => navigateToQuizPage(context, 'は～ほ', 'Quiz5.json', 10),
            buttonName: 'は～ほ',
          ),
          CustomButton(
            onPressed: () => navigateToQuizPage(context, 'ま～も', 'Quiz6.json', 10),
            buttonName: 'ま～も',
          ),
          CustomButton(
            onPressed: () => navigateToQuizPage(context, 'や～ら', 'Quiz7.json', 10),
            buttonName: 'や～ら',
          ),
          CustomButton(
            onPressed: () => navigateToQuizPage(context, 'わ～ん', 'Quiz8.json', 10),
            buttonName: 'わ～ん',
          ),
        ],
      ),
    );
  }

  void navigateToQuizPage(BuildContext context, String buttonName, String quizFileName, int maxQuestions) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizPage(buttonName: buttonName, quizFileName: quizFileName, maxQuestions: maxQuestions)),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonName;

  const CustomButton({Key? key, this.onPressed, required this.buttonName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(buttonName),
      ),
    );
  }
}
