import 'package:coingecko_client_generator/models/api_parameter_definition.dart';

class ApiEndpointDefinition {
  ApiEndpointDefinition({
    required this.path,
    required this.tag,
    required this.summary,
    required this.description,
    required this.responseCode,
    required this.responseDescription,
    required this.parameters,
  });
  String path;
  String tag;
  String summary;
  String description;
  int responseCode;
  String responseDescription;
  Map<String, ApiParameterDefinition> parameters;
}
