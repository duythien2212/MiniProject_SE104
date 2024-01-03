import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

Future<Uint8List?> importFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  Uint8List? fileBytes;
  if (result != null) {
    fileBytes = result.files.first.bytes;
    String fileName = result.files.first.name;
  }
  return fileBytes;
}
