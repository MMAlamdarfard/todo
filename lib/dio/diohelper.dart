import 'package:dio/dio.dart';
import 'package:todo/entity/note.dart';

// ignore: camel_case_types
class dioHelper {
  static sendData(List<note> allNote, Function() onSuccess, Function() onError) async {
    await Dio()
        .post('http://192.168.112.248:3000',
            data: allNote.map((e) => e.toJson()).toList())
        .then((value) {
      onSuccess();
    }).catchError((e){
     onError();
    })
    ;
  }
}
