import 'package:flutter/material.dart';
import 'package:okoul_quizu/routes/quiz/providers/questions_provider.dart';
import 'package:okoul_quizu/routes/quiz/widgets/countdown_timer_widget.dart';
import 'package:okoul_quizu/routes/quiz/widgets/question_tile_widget.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    Provider.of<QuestionsProvider>(context, listen: false).fetchQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var questionsProvider = Provider.of<QuestionsProvider>(context);
    var questions = questionsProvider.questionList;
    var index = questionsProvider.index;
    var hasClicked = questionsProvider.hasSkipped;

    if (questions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: theme.colorScheme.primary,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TimerWidget(theme: theme),
                    ],
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 32),
                                    Text(
                                      "Q${index + 1}. ${questions[index].getQuestion}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: theme.primaryColorDark,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 32),
                                    QuestionTile(
                                      questions: questions,
                                      index: index,
                                      option: 'a',
                                    ),
                                    const SizedBox(height: 8),
                                    QuestionTile(
                                      questions: questions,
                                      index: index,
                                      option: 'b',
                                    ),
                                    const SizedBox(height: 8),
                                    QuestionTile(
                                      questions: questions,
                                      index: index,
                                      option: 'c',
                                    ),
                                    const SizedBox(height: 8),
                                    QuestionTile(
                                      questions: questions,
                                      index: index,
                                      option: 'd',
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton.icon(
                                            icon: const Icon(Icons.skip_next),
                                            onPressed: hasClicked ||
                                                    index ==
                                                        questions.length - 1
                                                ? null
                                                : () {
                                                    questionsProvider
                                                        .nextQuestion();
                                                    context
                                                        .read<
                                                            QuestionsProvider>()
                                                        .skipQuestion();
                                                  },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                theme.colorScheme.primary,
                                              ),
                                            ),
                                            label: const Text("Skip"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
