import 'package:floor/floor.dart';

@entity
// ignore: camel_case_types
class note {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String title, notes, date, time;
  final int category, isSync, isDelete;
  note(
      {this.id,
      required this.title,
      required this.notes,
      required this.category,
      required this.date,
      required this.time,
      required this.isSync,
      required this.isDelete});
  factory note.defualt() {
   return note(
        title: "",
        notes: "",
        category: 3,
        date: "dd/mm/yy",
        time: "hh:mm",
        isSync: 0,
        isDelete: 0);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['note'] = notes;
    data['date'] = date;
    data['time'] = time;
    data['category'] = category;
    data['isDelete'] = isDelete;
    return data;
  }
  @override
  String toString() {
    return "id:$id,tite:$title,note:$notes, date:$date,time:$time,isSync:$isSync,isDelete:$isDelete";
  }
}
