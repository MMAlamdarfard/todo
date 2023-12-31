import 'package:get/get.dart';
import 'package:todo/db/dbhelper.dart';
import 'package:todo/entity/note.dart';

class Controller extends GetxController {
  @override
  void onReady() {
    getnotesTask();
    super.onReady();
  }

  // Database Section
  var noteList = <note>[].obs;
  showAllNote() async {
    for (var element in await getAllnote()) {
      print(element.toString());
    }
  }

  getnotesTask() async {
    // ignore: non_constant_identifier_names
    List<note> Note = await dbHelper.getAllNoteForList();
    noteList.assignAll(Note);
  }

  updatenoteForDeleting(bool isDelete, int id) async {
    await dbHelper.updateNoteForDeleting(isDelete, id);
    getnotesTask();
  }

  updatenoteForSyncing(bool isSync, int id) async {
    await dbHelper.updateNoteIsSync(isSync, id);
    getnotesTask();
  }

  updatenote(note note) async {
    await dbHelper.updateNote(note);
    getnotesTask();
  }

  Future<List<note>> getAllnote() async {
    return await dbHelper.getAllNote();
    //getnotesTask();
  }

  deleteNote(note note) async {
    await dbHelper.deletNote(note);
    getnotesTask();
  }
  insertToNote(note note) async {
    await dbHelper.insertTonote(note);
    getnotesTask();
  }

  Future<List<note>> getAllNoteForList() async {
    return await dbHelper.getAllNoteForList();
  }
  // Database Section

  //title task in bottom sheet
  var titleTask = "".obs;
  setTitle(String value) => titleTask.value = value;
  String getTitle() => titleTask.value;

  //note task  in bottom sheet
  var noteTask = "".obs;
  setnotes(String value) => noteTask.value = value;
  String getnotes() => noteTask.value;

  //radiobutton in bottom sheet status
  var radioStatus = 3.obs;
  setRadioStatus(int value) => radioStatus.value = value;
  int getRadioStatus() => radioStatus.value;

  //date selected in bottom sheet
  var dateSelected = "dd/mm/yy".obs;
  setDateSelected(String value) => dateSelected.value = value;
  String getDateSelected() => dateSelected.value;

  //time selected in bottom sheet
  var timeSelected = "hh:mm".obs;
  setTimeSelected(String value) => timeSelected.value = value;
  String getTimeSelected() => timeSelected.value;
}
