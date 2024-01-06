import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

Future<void> importFile(readFile) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  Uint8List? fileBytes;
  if (result != null) {
    fileBytes = result.files.first.bytes;
    String fileName = result.files.first.name;
  }
  readFile(fileBytes);
}
