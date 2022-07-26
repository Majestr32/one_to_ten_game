
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final questionsRepository = StateProvider((ref) => QuestionsRepository());
class QuestionsRepository{
  late final CollectionReference ref;
  QuestionsRepository(){
    ref = FirebaseFirestore.instance.collection('one_to_ten_questions');
  }
  Future<List<String>> getQuestions(String languageCode) async{
    return (await ref.get()).docs.map((e) => e.get('question_$languageCode') as String).toList();
  }
}