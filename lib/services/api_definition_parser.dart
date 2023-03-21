import 'dart:convert';
import 'dart:io';

import 'package:coingecko_client_generator/models/api_endpoint_definition.dart';
import 'package:coingecko_client_generator/models/api_parameter_definition.dart';

class ApiDefinitionParser {
  String filePath;
  Map<String, dynamic> _definitionMap = {};
  final Map<String, List<String>> _endpointGroup = {};
  Map<String, List<String>> get endpointGroup => _endpointGroup;
  final Map<String, ApiEndpointDefinition> _apiDefinitionMap = {};
  Map<String, ApiEndpointDefinition> get apiDefinitionMap => _apiDefinitionMap;

  ApiDefinitionParser(this.filePath) {
    _definitionMap = _getDefinition(filePath);
    _createDefinitionMap();
  }

  Map<String, dynamic> _getDefinition(String filePath) {
    var apiDefinition = File(filePath);
    return Map<String, dynamic>.from(
        jsonDecode(apiDefinition.readAsStringSync()));
  }

  Map<String, dynamic> _createDefinitionMap() {
    final String method = "get";
    for (var path in Map<String, dynamic>.from(_definitionMap["paths"]).keys) {
      final currentEndpoint = _definitionMap["paths"][path][method];
      final tag = currentEndpoint["tags"][0];

      _addToEndpointGroup(tag, path);
      _apiDefinitionMap[path] = ApiEndpointDefinition(
          path: path,
          tag: tag,
          summary: currentEndpoint["summary"] ?? "",
          description: currentEndpoint["description"] ?? "",
          responseCode: 200,
          responseDescription:
              currentEndpoint["responses"]["200"]?["description"] ?? "",
          parameters: currentEndpoint["parameters"] == null
              ? {}
              : _getParameters(currentEndpoint["parameters"]));
    }

    return _definitionMap["paths"];
  }

  void _addToEndpointGroup(String groupTag, String endpointPath) {
    if (_endpointGroup[groupTag] == null) {
      _endpointGroup[groupTag] = [];
    }
    _endpointGroup[groupTag]!.add(endpointPath);
  }

  String _convertTypeToDartType(String type) {
    switch (type) {
      case 'boolean':
        return 'bool';
      case 'integer':
        return 'int';
    }
    return type[0].toUpperCase() + type.substring(1);
  }

  Map<String, ApiParameterDefinition> _getParameters(
      List<dynamic> rawParameters) {
    Map<String, ApiParameterDefinition> parameters = {};
    for (var p in rawParameters) {
      parameters[p["name"]] = ApiParameterDefinition(
        name: p["name"],
        input: p["in"],
        description: p["description"],
        required: p["required"],
        type: _convertTypeToDartType(p["type"]),
      );
    }

    return parameters;
  }
}
