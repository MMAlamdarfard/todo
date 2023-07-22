import 'package:flutter/material.dart';
import 'package:todo/constant/appstyle.dart';
import 'package:todo/entity/note.dart';

class CardTodoListWidget extends StatelessWidget {
  final note notes;
  final VoidCallback onTap;
  final Function(int)? ondelete;
  const CardTodoListWidget({
    super.key,
    required this.notes,
    required this.onTap,
    required this.ondelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Ink(
          width: double.infinity,
          height: 136,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Container(
                  decoration:  BoxDecoration(
                      color: AppStyle.colors[notes.category-1],
                      borderRadius:const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  width: 20,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(notes.title,maxLines: 1,overflow: TextOverflow.ellipsis,),
                          subtitle: Text(notes.notes,maxLines: 1,overflow: TextOverflow.ellipsis,),
                          trailing: Transform.scale(
                            scale: 1,
                            child: Checkbox(
                              activeColor: AppStyle.colors[notes.category - 1],
                            
                              value: notes.isSync == 1,
                              onChanged: (value) {},
                              shape: const CircleBorder(),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -12),
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1.5,
                                color: AppStyle.colors[notes.category-1],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                   Row(
                                    children: [
                                      Text(notes.date),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(notes.time)
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (ondelete != null) {
                                        ondelete!(notes.id!);
                                      }
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.grey.shade500 ,
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
