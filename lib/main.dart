import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String question = '';
  String score = '0';
  int scoreCount = 0;
  int questionNumber = 0;
  List<Column> scoreKeeper = [];
  QuizBrain quizBrain = QuizBrain();

  void checkResponse(bool answer) {
    setState(() {
      if (questionNumber == 0) {
        scoreKeeper = [];
        scoreCount = 0;
        score = scoreCount.toString();
      }

      if (kDebugMode) {
        print(questionNumber);
        print(answer);
        print(quizBrain.questions[questionNumber].answer);
      }
      if (answer == quizBrain.questions[questionNumber].answer) {
        scoreKeeper.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${questionNumber + 1}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const Icon(
                Icons.check,
                color: Colors.green,
              ),
            ],
          ),
        );
        scoreCount++;
        score = scoreCount.toString();
      } else {
        scoreKeeper.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${questionNumber + 1}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ],
          ),
        );
      }
      questionNumber++;
      if (questionNumber > quizBrain.questions.length - 1) {
        questionNumber = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                '${questionNumber + 1} - ${quizBrain.questions[questionNumber].question}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkResponse(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkResponse(false);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  width: 1.0,
                  color: Colors.white,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Score',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.yellow,
                          ),
                        ),
                        Text(
                          score,
                          style: const TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: scoreKeeper,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
