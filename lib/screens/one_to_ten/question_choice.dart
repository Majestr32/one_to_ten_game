
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:one_to_ten_game/providers/one_to_ten_game_provider.dart';
import 'package:one_to_ten_game/screens/one_to_ten/game_wrapper.dart';
import 'package:one_to_ten_game/screens/one_to_ten/loading_screen.dart';
import 'package:one_to_ten_game/widgets/question_tile.dart';

class QuestionChoice extends ConsumerStatefulWidget {
  const QuestionChoice({Key? key}) : super(key: key);

  @override
  ConsumerState<QuestionChoice> createState() => _QuestionChoiceState();
}

class _QuestionChoiceState extends ConsumerState<QuestionChoice> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(oneToTenGameProvider.notifier).generateThreeRandomQuestions();
    });
  }
  @override
  Widget build(BuildContext context) {
    final randomQuestions = ref.watch(oneToTenGameProvider).randomQuestions;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) => randomQuestions.isEmpty ? Container() : Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: QuestionTile(question: randomQuestions[index], onTap: (){
                ref.read(oneToTenGameProvider.notifier).chooseQuestion(ref.watch(oneToTenGameProvider).randomQuestions[index]);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoadingScreen()));
              },),
            ),
          ),
        ),
      )),
    );
  }
}
