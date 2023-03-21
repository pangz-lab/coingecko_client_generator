import 'package:coingecko_client_generator/models/parameter_definition.dart';

class MethodDefinition {
  MethodDefinition({
    required this.template,
    required this.name,
    required this.endpointPath,
    this.parameters
  });

  String template;
  String name;
  String endpointPath;
  Map<String, ParameterDefinition>? parameters;
  String _stringifiedParameters = "";
  String _stringifiedQueryKeyValueUpdate = "";
  static final String _logicLine = '''_path = createEndpointUrlPath(
      rawQueryItems: {
SET_KV_UPDATE_LINE_ENTRY
      },
      endpointPath: "ENDPOINT_PATH"
    );
    ''';
//   static final String _logicLine = '''List<String> keyValueList = [];
//     keyValueList.addAll([
// SET_KV_UPDATE_LINE_ENTRY
//     ]);
//     keyValueList.removeWhere((e) => e.trim().isEmpty);
//     _path += keyValueList.join('&');
//     ''';

  String _stringifyParameters() {
    if (parameters?.isEmpty ?? true) { return ""; }

    List<String> result = [];
    List<String> queryKeyValueUpdate = [];
    final spacer = "    ";
    for (var parameter in parameters!.values) {
      result.add(parameter.toString());
      queryKeyValueUpdate.add(
        _getQueryKeyValueUpdate(parameter.name, parameter.methodNeutralName)
      );
    }
    _stringifiedParameters = "{\n$spacer${result.join(",\n$spacer")}\n  }";
    _stringifiedQueryKeyValueUpdate = queryKeyValueUpdate.join(",\n");
    return _stringifiedParameters;
  }

  @override
  String toString() {
    var parameterResult = _stringifyParameters();
    if (parameterResult.isNotEmpty) {
      _stringifiedQueryKeyValueUpdate = _logicLine.replaceAll(
        "SET_KV_UPDATE_LINE_ENTRY", _stringifiedQueryKeyValueUpdate
      ).replaceAll("ENDPOINT_PATH", endpointPath);
    }
    return template
        .replaceAll('METHOD_NAME', name)
        .replaceAll('PARAMETERS', _stringifiedParameters)
        .replaceAll('BASE_ENDPOINT_UPDATE', _stringifiedQueryKeyValueUpdate);
  }

  String _getQueryKeyValueUpdate(String name, String value) {
    return "        '$name': $value";
  }
}

/***
 * _path += formKeyValueQuery({
      'coin_id': coinId
    });
 */
