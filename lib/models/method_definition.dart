import 'package:coingecko_client_generator/models/method_comment_definition.dart';
import 'package:coingecko_client_generator/models/parameter_definition.dart';

class MethodDefinition {
  MethodDefinition({
    required this.template,
    required this.name,
    required this.endpointPath,
    required this.comment,
    this.parameters
  });

  final String template;
  final String name;
  final String endpointPath;
  final String comment;
  final Map<String, ParameterDefinition>? parameters;
  String _stringifiedParameters = "";
  String _stringifiedQueryKeyValueUpdate = "";
  static final String _logicLine = '''_path = createEndpointUrlPath(
      rawQueryItems: {
SET_KV_UPDATE_LINE_ENTRY
      },
      endpointPath: "ENDPOINT_PATH"
    );
    ''';

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
    } else {
      _stringifiedQueryKeyValueUpdate = "_path = '$endpointPath';\n    ";
    }
    return template
      .replaceAll('METHOD_NAME', name)
      .replaceAll('PARAMETERS', _stringifiedParameters)
      .replaceAll('BASE_ENDPOINT_UPDATE', _stringifiedQueryKeyValueUpdate)
      .replaceAll('METHOD_COMMENT', comment);
  }

  String _getQueryKeyValueUpdate(String name, String value) {
    return "        '$name': $value";
  }
}