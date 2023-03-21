import 'dart:io';

import 'package:coingecko_client_generator/models/api_endpoint_definition.dart';
import 'package:coingecko_client_generator/models/class_definition.dart';
import 'package:coingecko_client_generator/models/method_definition.dart';
import 'package:coingecko_client_generator/models/parameter_definition.dart';
import 'package:coingecko_client_generator/services/api_definition_parser.dart';
import 'package:coingecko_client_generator/services/file_generator.dart';

class CoinGeckoClientGenerator {
  ApiDefinitionParser parser;
  String classTemplatePath;
  String methodTemplatePath;
  String _classTemplate = "";
  String _methodTemplate = "";
  CoinGeckoClientGenerator(
    this.parser,
    this.classTemplatePath,
    this.methodTemplatePath
  ) {
    _classTemplate = _getTemplateContent(classTemplatePath);
    _methodTemplate = _getTemplateContent(methodTemplatePath);
  }

  Future<void> generate() async {
    var endpointGroupList = parser.endpointGroup.keys.toList();
    Map<String, String> classNames = {};

    for (var endpointGroup in endpointGroupList) {
      classNames = _createClassAndFileName(endpointGroup);
      await _generateClassFile(
        endpointGroup,
        classNames["file"]!,
        ClassDefinition(
          template: _classTemplate,
          name: classNames["class"]!,
          baseEndpoint: "/$endpointGroup",
          methods: _createMethodDefinitionList(endpointGroup)
        )
      );
    }
  }

  List<MethodDefinition> _createMethodDefinitionList(String endpoint) {
    List<MethodDefinition> methodDefinitionList = [];
    ApiEndpointDefinition? endpointDefinition;

    for (var endpointMember in parser.endpointGroup[endpoint]!) {
      endpointDefinition = parser.apiDefinitionMap[endpointMember] as ApiEndpointDefinition;
      methodDefinitionList.add(
        MethodDefinition(
          template: _methodTemplate,
          name: _convertPathToMethodName(endpointMember),
          parameters: endpointDefinition.parameters.map(
            (key, param) {
              return MapEntry(
                param.name,
                ParameterDefinition(
                name: param.name,
                dataType: param.type,
                required: param.required
              ));
            })
        )
      );
    }
    return methodDefinitionList;
  }

  Map<String, String> _createClassAndFileName(String name) {
    return {
      "file": _createCleanFileName("${name}_endpoint.dart"),
      "class": "${_convertNameToUpperCamelCase(name)}Endpoint"
    };
  }

  String _createCleanFileName(String name) {
    return name.replaceAll("(beta)", "")
      .replaceAll(" ", "");
  }

  String _convertPathToMethodName(String path) {
    return "get${path.split("/").map(
      (e) {
        if(e.isEmpty || e.startsWith("{")) { return ""; }
        return _convertNameToUpperCamelCase(e);
      }).toList().join("")}";
  }

  String _convertNameToUpperCamelCase(String name) {
    if(name.isEmpty) { return ""; }
    if(!name.contains("_")) {
      return name[0].toUpperCase() + name.substring(1).toLowerCase();
    }
    return name.split('_').map((n) {
      if(n.isEmpty || n.contains('beta')) { return ''; }
      var convertedName = n.trim().toLowerCase();
      return convertedName[0].toUpperCase() + convertedName.substring(1);
    }).join('');
  }

  Future<void> _generateClassFile(String folderName, String fileName, ClassDefinition classDefinition) async {
    var directory = 'generated_class/${_createCleanFileName(folderName)}';
    Directory(directory).createSync(recursive: true);
    await FileGenerator.generate("$directory/$fileName", classDefinition.toString());
  }

  String _getTemplateContent(String templatefile) {
    var classFile = File(templatefile);
    return classFile.readAsStringSync();
  }
}
// var parser = ApiDefinitionParser('coingecko-api.v3.json');
// print(parser.apiDefinitionMap);

// Map<String, dynamic> getApiDefinition(String filePath) {
//   var apiDefinition = File(filePath);
//   return Map<String, dynamic>.from(jsonDecode(apiDefinition.readAsStringSync()));
// }

// String getClassTemplate(String templatefile) {
//   var classFile = File(templatefile);
//   return classFile.readAsStringSync();
// }

// String defineClassContent({
//   required ClassFileDefinition classDefinition,
//   required String template
// }) {
//    return template.replaceAll('CLASS_NAME', classDefinition.name)
//     .replaceAll('BASE_ENDPOINT', classDefinition.baseEndpoint)
//     .replaceAll('METHODS', classDefinition.stringifyParameters());
// }

// Future<void> generateClassFile(String filePath, String definition) async {
//   var classFile = File(filePath);
//   var sink = classFile.openWrite();
//   sink.write(definition);
//   await sink.flush();
//   await sink.close();
// }
