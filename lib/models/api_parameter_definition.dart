class ApiParameterDefinition {
  const ApiParameterDefinition({
    required this.name,
    required this.input,
    required this.description,
    required this.required,
    required this.type
  });
  final String name;
  final String input;
  final String description;
  final bool required;
  final String type;
}
