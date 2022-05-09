//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:file_picker/file_picker.dart';
//
// class SaveFileTest extends StatefulWidget {
//   const SaveFileTest({Key? key}) : super(key: key);
//
//   @override
//   _SaveFileTestState createState() => _SaveFileTestState();
// }
//
// class _SaveFileTestState extends State<SaveFileTest> {
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getFilePath();
//   }
//
//
//   getFilePath() async{
//
//     Directory?  path = await getDownloadsDirectory();
//     print(path?.path);
//     String? path2 = path?.path;
//
//     File file = File(path2! + '/123123.txt');
//     await file.writeAsString("放大顺丰大顺丰的撒");
//
//
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       floatingActionButton: ElevatedButton(
//         child: Text("anniu"),
//         onPressed: () async{
//           String? outputFile = await FilePicker.platform.saveFile(
//             dialogTitle: 'Please select an output file:',
//             fileName: 'output-file.pdf',
//           );
//
//           if (outputFile == null) {
//             // User canceled the picker
//           }
//
//
//           // String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
//           // print(selectedDirectory);
//
//           // FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
//           //
//           // if (result != null) {
//           //   List<File> files = result.paths.map((path) => File(path!)).toList();
//           //   for (File file in files) {
//           //     List<String> readAsLines = await file.readAsLines();
//           //     for (var o in readAsLines) {
//           //       print(o);
//           //     }
//           //   }
//           // } else {
//           //   // User canceled the picker
//           // }
//         },
//       ),
//       body: Container(),
//     );
//   }
// }
