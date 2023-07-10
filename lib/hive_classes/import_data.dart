import 'dart:io' show Platform, File;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<String> getHiveFilePath() async {
  if (Platform.isWindows) {
    final appDirectory = await getApplicationDocumentsDirectory();
    return appDirectory.path;
  } else {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    return appDocumentsDirectory.path;
  }
}

void importHiveData(String boxName) async {
  final hiveFilePath = await getHiveFilePath();
  final hiveBoxName = boxName;

  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['hive'],
  );

  if (result != null) {
    File file = File(result.files.single.path!);
    String newFilePath = '$hiveFilePath${Platform.pathSeparator}$hiveBoxName.hive';

    try {
      await file.copy(newFilePath);

      // Open the imported Hive box
      await Hive.openBox(hiveBoxName);

      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Hive database imported successfully.')),
      );
    } catch (e) {
      // print('Error importing Hive database: $e');
    }
  }
}
