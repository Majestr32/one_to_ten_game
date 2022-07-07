
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
    ref.read(oneToTenGameProvider.notifier).generateThreeRandomQuestions();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuestionTile(question: ref.watch(oneToTenGameProvider).randomQuestions[0], onTap: (){
              ref.read(oneToTenGameProvider.notifier).chooseQuestion(ref.watch(oneToTenGameProvider).randomQuestions[0]);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoadingScreen()));
            },),
            SizedBox(height: 20,),
            QuestionTile(question: ref.watch(oneToTenGameProvider).randomQuestions[1], onTap: (){
              ref.read(oneToTenGameProvider.notifier).chooseQuestion(ref.watch(oneToTenGameProvider).randomQuestions[1]);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoadingScreen()));
            },),
            SizedBox(height: 20,),
            QuestionTile(question: ref.watch(oneToTenGameProvider).randomQuestions[2], onTap: (){
              ref.read(oneToTenGameProvider.notifier).chooseQuestion(ref.watch(oneToTenGameProvider).randomQuestions[2]);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoadingScreen()));
            },),
          ],
        ),
      ),
    );
  }
}
