import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo/constant/appstyle.dart';
import 'package:todo/dio/diohelper.dart';
import 'package:todo/entity/note.dart';
import 'package:todo/widget/bottomsheet.dart';

import '../controller/controller.dart';
import '../widget/cardtodolistwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Controller _controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    _controller.showAllNote();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade300,
            radius: 30,
            child: Image.asset("asset/profile.jpg"),
          ),
          title: Text(
            "Hello I m",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
          subtitle: const Text(
            "Mohammad Mahdi",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                    onPressed: () async {
                      var c = context;
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AppStyle.dialog(
                                  context,
                                  Icons.upload_rounded,
                                  "do you want to upload all notes?", () async {
                                Navigator.of(context).pop();
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext ucontext) {
                                    c = ucontext;
                                    return AppStyle.showLoaderDialog(ucontext);
                                  },
                                );
                                List<note> notes =
                                    await _controller.getAllnote();

                                dioHelper.sendData(notes, () {
                                  Navigator.of(c).pop();
                                  updateNote(notes, _controller);
                                  // ignore: use_build_context_synchronously
                                }, () {
                                  Navigator.of(c).pop();
                                });
                              }));
                    },
                    icon: const Icon(CupertinoIcons.calendar)),
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.bell))
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today 's Task",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Wednesday 11 May",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    _showModalbottomSheet(false, null);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD5E8FA),
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: const Text(
                    "+ New Task",
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return ListView.builder(
                  itemCount: _controller.noteList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    note notes = _controller.noteList[index];
                    return CardTodoListWidget(
                        notes: notes,
                        ondelete: (id) async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AppStyle.dialog(
                                  context, Icons.delete_forever,
                                   "do you want to delete this note?",
                                   () async {
                                   Navigator.of(context).pop();
                                   await _controller.updatenoteForDeleting(
                                      true, id);
                                });
                              });
                        },
                        onTap: () {
                          _showModalbottomSheet(true, notes);
                        });
                  });
            }),
          ]),
        ),
      ),
    );
  }

  _showModalbottomSheet(bool isUpdate, note? notes) {
    note notess = notes ?? note.defualt();
    _controller.setTitle(notess.title);
    _controller.setnotes(notess.notes);
    if (isUpdate) {
      _controller.setDateSelected(notess.date);
      _controller.setTimeSelected(notess.time);
      _controller.setRadioStatus(notess.category);
    }
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        context: context,
        builder: (context) =>
            MyBottomSheet(isUpdate: isUpdate, notes: notess)).then((value) {
      _controller.setDateSelected("dd/mm/yy");
      _controller.setTimeSelected("hh:mm");
      _controller.setTitle("");
      _controller.setnotes("");
      _controller.setRadioStatus(3);
    });
  }
}

void updateNote(List<note> notes, Controller controller) async {
  for (note n in notes) {
    if (n.isDelete == 1) {
      await controller.deleteNote(n);
    }
    await controller.updatenoteForSyncing(true, n.id!);
  }
}
