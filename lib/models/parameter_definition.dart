class ParameterDefinition {
  const ParameterDefinition({
    required this.name,
    required this.dataType,
    required this.required,
  });

  final String name;
  final String dataType;
  final bool required;
  String get methodNeutralName => _convertNameToPascalCase();

  String _convertNameToPascalCase() {
    var i = 0;
    return name.split('_').map((n) {
      var convertedName = n.toLowerCase();
      convertedName = (i == 0)
          ? convertedName
          : convertedName[0].toUpperCase() + convertedName.substring(1);
      i++;
      return convertedName;
    }).join('');
  }

  @override
  String toString() {
    return "${(required) ? "required $dataType" : "$dataType?"} $methodNeutralName";
  }
}
