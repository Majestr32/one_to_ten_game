
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionsRepository{
  late final CollectionReference ref;
  QuestionsRepository(){
    ref = FirebaseFirestore.instance.collection('one_to_ten_questions');
  }
  Future<List<String>> getQuestions() async{
    return (await ref.get()).docs.map((e) => e.get('question_de') as String).toList();
  }
}