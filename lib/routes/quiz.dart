import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.colorScheme.tertiary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text('1:52',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 22,
                    //         color: Colors.white))
                    CircularCountDownTimer(
                      duration: 120,
                      initialDuration: 0,
                      controller: CountDownController(),
                      width: MediaQuery.of(context).size.width / 5.5,
                      height: MediaQuery.of(context).size.height / 5.5,
                      // ringColor: Colors.grey[300]!,
                      ringColor: Colors.white,
                      fillColor: theme.colorScheme.primary,
                      backgroundColor: theme.colorScheme.primary,
                      strokeWidth: 8.0,
                      textStyle: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textFormat: CountdownTextFormat.MM_SS,
                      isReverse: true,
                      autoStart: true,
                      onStart: () {
                        // debugPrint('Countdown Started');
                      },
                      onComplete: () {
                        // debugPrint('Countdown Ended');
                      },
                      onChange: (String timeStamp) {
                        // debugPrint('Countdown Changed $timeStamp');
                      },
                    ),
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
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Question 1',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  const SizedBox(height: 32),
                                  Text('Who created Ruby on Rails?',
                                      style: theme.textTheme.headline6,
                                      textAlign: TextAlign.start),
                                  const SizedBox(height: 32),
                                  // SizedBox(
                                  //     width: double.infinity,
                                  //     child: TextButton(
                                  //       onPressed: () {},
                                  //       style: ButtonStyle(
                                  //           alignment: Alignment.centerLeft,
                                  //           padding: MaterialStateProperty.all(
                                  //               const EdgeInsets.symmetric(
                                  //                   horizontal: 8, vertical: 16))),
                                  //       child: const Text('Option 1'),
                                  //     )),
                                  // SizedBox(
                                  //     width: double.infinity,
                                  //     child: TextButton(
                                  //         onPressed: () {},
                                  //         style: ButtonStyle(
                                  //             alignment: Alignment.centerLeft,
                                  //             padding: MaterialStateProperty.all(
                                  //                 const EdgeInsets.symmetric(
                                  //                     horizontal: 8, vertical: 16))),
                                  //         child: const Text('Option 2'))),
                                  // SizedBox(
                                  //     width: double.infinity,
                                  //     child: TextButton(
                                  //         onPressed: () {},
                                  //         style: ButtonStyle(
                                  //             alignment: Alignment.centerLeft,
                                  //             padding: MaterialStateProperty.all(
                                  //                 const EdgeInsets.symmetric(
                                  //                     horizontal: 8, vertical: 16))),
                                  //         child: const Text('Option 3'))),
                                  // SizedBox(
                                  //     width: double.infinity,
                                  //     child: TextButton(
                                  //         onPressed: () {},
                                  //         style: ButtonStyle(
                                  //             alignment: Alignment.centerLeft,
                                  //             padding: MaterialStateProperty.all(
                                  //                 const EdgeInsets.symmetric(
                                  //                     horizontal: 8, vertical: 16))),
                                  //         child: const Text('Option 4'))),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      style: questionOptionStyle(),
                                      child: const Text("A. Paul Graham"),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      style: questionOptionStyle(),
                                      child: const Text("B. DHH"),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      style: questionOptionStyle(),
                                      child: const Text("C. Bill Gates"),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      style: questionOptionStyle(),
                                      child: const Text("D. Tom Watson"),
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                theme.colorScheme.tertiary)),
                                    child: const Text("Skip"),
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
        ));
  }
}

ButtonStyle questionOptionStyle() {
  return ButtonStyle(
    alignment: Alignment.centerLeft,
    padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 12, vertical: 16)),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
  );
}
