import 'package:flutter/material.dart';
import 'Api_service.dart';
import 'Question.dart';
import 'Result_screen.dart';
import 'Secoundpage.dart';

class QuizPage extends StatefulWidget {
  final String buttonName;
  final String quizFileName;
  final int maxQuestions;

  QuizPage({
    required this.buttonName,
    required this.quizFileName,
    required this.maxQuestions,
  });

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [];
  List<bool?> userAnswers = [];
  int currentQuestionIndex = 0;
  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    userAnswers = List.generate(widget.maxQuestions, (index) => null);
  }

  Future<void> _loadQuestions() async {
    try {
      questions = await ApiService.fetchQuestions(widget.quizFileName, widget.maxQuestions);
      setState(() {
        questions.shuffle();
        print('Shuffled Questions: $questions');
      });
    } catch (e) {
      print('質問の読み込みエラー: $e');
    }
  }


  void checkAnswer(bool userAnswer) {
    print('Before checkAnswer - userAnswers: $userAnswers');
    print('userAnswer: $userAnswer');
    print('Correct Answer: ${questions[currentQuestionIndex].answer}');
    String explanation = questions[currentQuestionIndex].explanation;
    bool isCorrect = userAnswer == questions[currentQuestionIndex].answer;

    String userSymbol = userAnswer ? '〇' : '☓';
    String correctAnswerSymbol = questions[currentQuestionIndex].answer ? '〇' : '☓';

    bool? userChoice = userAnswer;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('あなたの回答: $userSymbol'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              isCorrect
                  ? Text('正解！')
                  : Text('不正解.. 正解は「$correctAnswerSymbol」です。'),
              Text(explanation),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    if (currentQuestionIndex < questions.length - 1) {
                      currentQuestionIndex++;
                    } else {
                      showResultDialog(userChoice);
                    }
                  });
                },
                child: Text(
                  currentQuestionIndex < questions.length - 1 ? '次へ' : '結果を見る',
                ),
              ),
            ],
          ),
        );
      },
    );

    setState(() {
      userAnswers[currentQuestionIndex] = userAnswer;
    });

    if (isCorrect) {
      setState(() {
        correctAnswers++;
        print('DEBUG: correctAnswers = $correctAnswers');
      });
    }
  }

  void showResultDialog(bool? userChoice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          questions: questions,
          userAnswers: userAnswers,
          userChoices: List.generate(questions.length, (index) {
            return index == currentQuestionIndex ? userChoice : null;
          }),
          retryQuiz: () {
            Navigator.of(context).pop();
            setState(() {
              currentQuestionIndex = 0;
              correctAnswers = 0;
            });
            _loadQuestions();
          },
          goToHome: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NewPage()),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('〇☓ゲーム'),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '第${currentQuestionIndex + 1}問',
            ),
            Text(
              '${questions.isNotEmpty ? questions[currentQuestionIndex].text : "Loading..."}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (questions.isNotEmpty) {
                      checkAnswer(true);
                    }
                  },
                  child: Text('〇'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,  // ボタンの背景色
                    onPrimary: Colors.white,  // ボタンのテキスト色
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),  // ボタン内のパディング
                    textStyle: TextStyle(fontSize: 22),  // ボタンのテキストのスタイル
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),  // ボタンの角の半径
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (questions.isNotEmpty) {
                      checkAnswer(false);
                    }
                  },
                  child: Text('☓'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,  // ボタンの背景色
                    onPrimary: Colors.white,  // ボタンのテキスト色
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),  // ボタン内のパディング
                    textStyle: TextStyle(fontSize: 22),  // ボタンのテキストのスタイル
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),  // ボタンの角の半径
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
