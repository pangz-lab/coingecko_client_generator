import 'dart:io';

class FileGenerator {
  static Future<bool> generate(String filePath, String classDefinition) async {
    try {
      var classFile = File(filePath);
      var sink = classFile.openWrite();
      sink.write(classDefinition);
      await sink.flush();
      await sink.close();
    } catch (_) {
      return false;
    }
    return true;
  }
}
