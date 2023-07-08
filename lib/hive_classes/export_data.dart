import 'dart:io' show Platform, File, Directory;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management/widgets/my_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_saver/file_saver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Register adapters and open boxes
  // ...
}

Future<String> getHiveFilePath() async {
  if (Platform.isWindows) {
    final appDirectory = await getApplicationDocumentsDirectory();
    return appDirectory.path;
  } else {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    return appDocumentsDirectory.path;
  }
}

void exportHiveData(BuildContext context, String boxName) async {
  final time = DateTime.now().toLocal().toString().substring(0, 19).replaceAll(':', '`');
  final hiveFilePath = await getHiveFilePath();
  final hiveBoxPath = '$hiveFilePath${Platform.pathSeparator}$boxName.hive';

  // Copy the Hive box file to a new location
  final newFilePath = '$hiveFilePath${Platform.pathSeparator}${boxName}_${time}_backup.hive';

  if (Platform.isWindows) {
    final hiveBoxDirectory = Directory(hiveFilePath);
    await hiveBoxDirectory.create(recursive: true);
    await File(hiveBoxPath).copy(newFilePath);
  } else {
    await File(hiveBoxPath).copy(newFilePath);
  }

  // Provide the file to the user for download
  final exportFile = File(newFilePath);

  if (Platform.isWindows) {
    await FileSaver.instance.saveFile(
      bytes: exportFile.readAsBytesSync(),
      name: 'Save Hive Data',
      // mimeType: MimeType.hive,
    );
  } else {
    final bytes = await exportFile.readAsBytes();
    await File('$hiveFilePath${Platform.pathSeparator}${boxName}_${time}_backup.hive').writeAsBytes(bytes);
  }
  // ignore: use_build_context_synchronously
  MySnackbar().show(context, 'Success', 'Date is exported', ContentType.success);
}
