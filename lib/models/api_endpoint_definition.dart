import 'package:coingecko_client_generator/models/api_parameter_definition.dart';

class ApiEndpointDefinition {
  const ApiEndpointDefinition({
    required this.path,
    required this.tag,
    required this.summary,
    required this.description,
    required this.responseCode,
    required this.responseDescription,
    required this.parameters,
  });
  final String path;
  final String tag;
  final String summary;
  final String description;
  final int responseCode;
  final String responseDescription;
  final Map<String, ApiParameterDefinition> parameters;
}
