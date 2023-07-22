import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStyle {
  static var colors = [
    Colors.green,
    Colors.blue.shade700,
    Colors.red,
  ];
  static const headingone =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black);

  static Dialog dialog(BuildContext context, IconData icon, String text,
          Function() onConfirm) =>
      Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0)), //this right here
        child: Container(
          height: Get.height * 0.15,
          width: Get.width * 0.85,
          margin:
              const EdgeInsets.only(top: 30, left: 20, right: 15, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(children: [
                WidgetSpan(
                    child: Icon(
                  icon,
                  size: 25,
                  color: Colors.grey.shade500,
                )),
      
                TextSpan(
                    text: text,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w300))
              ])),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed:onConfirm  
                        ,
                        child: const Text(
                          "confirm",
                          style: TextStyle(color: Colors.blue),
                        )),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "cancel",
                          style: TextStyle(color: Colors.grey),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      );
     static Dialog showLoaderDialog(BuildContext context)=>
          Dialog(
            
           shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0)), //this right here
        child:  
          Container(
             height: Get.height * 0.1,
             width: Get.width * 0.85,
             margin:
              const EdgeInsets.all(10),
            child: Row(
             children: [
               const CircularProgressIndicator(),
                Container(margin:const EdgeInsets.only(left: 7),child:const Text("Uploading..." )),
             ],),
          ),
    );
}
// const Padding(
//           padding:  EdgeInsets.all(15.0),
//           child: Text('Cool', style: TextStyle(color: Colors.red),),
//         ),
//         const Padding(
//           padding: EdgeInsets.all(15.0),
//           child: Text('Awesome', style: TextStyle(color: Colors.red),),
//         ),
      
//         TextButton(onPressed: () {
//           Navigator.of(context).pop();
//         },
//         child: const Text('Got It!', style: TextStyle(color: Colors.purple, fontSize: 18.0),))