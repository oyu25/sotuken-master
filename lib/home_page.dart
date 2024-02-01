import 'package:flutter/material.dart';
import 'package:jikken1/secoundpage.dart';
import 'quiz_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewPage()),
          );
        },
        child: Container(
          padding: EdgeInsets.all(20.0), // コンテナ全体のパディング
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 中央に配置
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter, // テキストを上部に配置
                child: Text(
                  'みやぎ県の方言についてクイズで学んでみましょう！',
                  style: TextStyle(
                    fontSize: 20.0, // テキストのフォントサイズ
                    color: Colors.black, // テキストの色
                  ),
                ),
              ),
              SizedBox(height: 50), // テキストと画像の間に余白を追加
              Center(
                child: Image.asset(
                  'assets/miyagi.png',
                  width: 200.0, // 画像の幅
                  height: 200.0, // 画像の高さ
                ),
              ),
              SizedBox(height: 90), // 画像とボタンの間に余白を追加
              Align(
                alignment: Alignment.bottomCenter, // ボタンを下部に配置
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewPage()),
                    );
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(
                        vertical: 15.0, // 縦方向のパディング
                        horizontal: 70.0, // 横方向のパディング
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue, // ボタンの背景色
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white, // ボタンのテキスト色
                    ),
                  ),
                  child: Text(
                    'クイズの選択欄へ進む',
                    style: TextStyle(
                      fontSize: 15.0, // テキストのフォントサイズ
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
