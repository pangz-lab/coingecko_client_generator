import 'package:coingecko_client_generator/models/method_definition.dart';

class ClassDefinition {
  ClassDefinition(
      {required this.template,
      required this.name,
      required this.baseEndpoint,
      required this.methods});
  String template;
  String name;
  String baseEndpoint;
  List<MethodDefinition> methods;

  String stringifyMethods() {
    if (methods.isEmpty) {
      return "";
    }
    return methods.map((method) => method.toString()).join("\n\n");
  }

  @override
  String toString() {
    return template
        .replaceAll('CLASS_NAME', name)
        .replaceAll('BASE_ENDPOINT', baseEndpoint)
        .replaceAll('METHODS', stringifyMethods());
  }
}
