import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/models.dart';

class Database {

  String level;

  Database({this.level});

  final CollectionReference odyssee = Firestore.instance.collection('OdysseeTable');


  List<Hunt> huntFromSnap (QuerySnapshot snapshot) {
   return snapshot.documents.map( ((doc) {
            print('Getting the documents now ............');
            return Hunt(
                    huntName: doc.data['HuntName']);
                  }
                    )).toList();
  }

  Stream<List<Hunt>> get hunt{
 
    return odyssee.where('DifficultyLevel', isEqualTo: level).snapshots()
                  .map((snapshot) => huntFromSnap(snapshot));
  }

}