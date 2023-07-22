import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/constant/appstyle.dart';
import 'package:todo/entity/note.dart';
import 'package:todo/widget/TextFieldWidget.dart';
import 'package:todo/widget/datetimewidget.dart';
import 'package:todo/widget/radiowidget.dart';

import '../controller/controller.dart';

class MyBottomSheet extends StatefulWidget {
  final bool isUpdate;
  final note notes;
  const MyBottomSheet({super.key, required this.isUpdate, required this.notes});

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  final Controller _controller = Get.find();
  late String title;
  late String notes;
  @override
  Widget build(BuildContext context) {
    TextEditingController titlecontroller =
        TextEditingController(text: _controller.getTitle());
    titlecontroller.selection = TextSelection.fromPosition(
        TextPosition(offset: titlecontroller.text.length));
    TextEditingController notecontroller =
        TextEditingController(text: _controller.getnotes());
    notecontroller.selection = TextSelection.fromPosition(
        TextPosition(offset: notecontroller.text.length));
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.77,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              "New Task Todo",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey.shade200,
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Title Task",
            style: AppStyle.headingone,
          ),
          const SizedBox(
            height: 6,
          ),
          MyTextField(
            onChanged: (value) => _controller.setTitle(value),
            hintText: "Add Task Name",
            maxline: 1,
            textEditingController: titlecontroller,
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Description",
            style: AppStyle.headingone,
          ),
          const SizedBox(
            height: 6,
          ),
          MyTextField(
            onChanged: (value) => _controller.setnotes(value),
            hintText: "Add Description",
            maxline: 8,
            textEditingController: notecontroller,
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Category",
            style: AppStyle.headingone,
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Row(
              children: [
                RadioWidget(
                  titleRadio: "Learning",
                  categoryColor: AppStyle.colors[0],
                  onTap: (value) => _controller.setRadioStatus(value!),
                  value: 1,
                  selectedvalue: _controller.getRadioStatus(),
                ),
                RadioWidget(
                  titleRadio: "working",
                  categoryColor: AppStyle.colors[1],
                  onTap: (value) => _controller.setRadioStatus(value!),
                  value: 2,
                  selectedvalue: _controller.getRadioStatus(),
                ),
                RadioWidget(
                  titleRadio: "general",
                  categoryColor: AppStyle.colors[2],
                  onTap: (value) => _controller.setRadioStatus(value!),
                  value: 3,
                  selectedvalue: _controller.getRadioStatus(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dateTimeWidget(
                    title: "Date",
                    textValue: _controller.getDateSelected(),
                    icon: CupertinoIcons.calendar,
                    onTap: () async {
                      final value = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030));
                      if (value != null) {
                        _controller
                            .setDateSelected(DateFormat.yMd().format(value));
                      }
                    }),
                const SizedBox(
                  width: 22,
                ),
                dateTimeWidget(
                  title: "Time",
                  textValue: _controller.getTimeSelected(),
                  icon: CupertinoIcons.clock,
                  onTap: () async {
                    final value = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (value != null) {
                      // ignore: use_build_context_synchronously
                      _controller.setTimeSelected(value.format(context));
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _controller.setDateSelected("dd/mm/yy");
                  _controller.setTimeSelected("hh:mm");
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    side: BorderSide(color: Colors.blue.shade800),
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text("Cancel"),
              )),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                onPressed: () async {
                  String notes = notecontroller.text;
                  String title = titlecontroller.text;
                  if (notes.isEmpty ||
                      title.isEmpty ||
                      _controller.getDateSelected() == "dd/mm/yy" ||
                      _controller.getTimeSelected() == "hh:mm") {
                    Get.snackbar("Required", "All fields Are required!",
                        snackPosition: SnackPosition.BOTTOM,
                        colorText:
                            !Get.isDarkMode ? Colors.white : Colors.black,
                        backgroundColor:
                            Get.isDarkMode ? Colors.white : Colors.black,
                        icon: Icon(
                          Icons.warning_amber_rounded,
                          color: !Get.isDarkMode ? Colors.white : Colors.black,
                        ));
                  } else {
                    note n = note(
                        title: title,
                        notes: notes,
                        category: _controller.getRadioStatus(),
                        date: _controller.getDateSelected(),
                        time: _controller.getTimeSelected(),
                        isSync: 0,
                        isDelete: 0);
                    if (widget.isUpdate) {
                      n.id = widget.notes.id;
                      await  _controller.updatenote(n);
                    } else {
                      await _controller.insertToNote(n);
                    }

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.isUpdate ? "Update" : "Create"),
              )),
            ],
          )
        ],
      ),
    );
  }
}
