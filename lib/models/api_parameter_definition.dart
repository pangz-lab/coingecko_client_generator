class ApiParameterDefinition {
  ApiParameterDefinition(
      {required this.name,
      required this.input,
      required this.description,
      required this.required,
      required this.type});
  String name;
  String input;
  String description;
  bool required;
  String type;
}
