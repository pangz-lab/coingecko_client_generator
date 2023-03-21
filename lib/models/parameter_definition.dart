class ParameterDefinition {
  ParameterDefinition({
    required this.name,
    required this.dataType,
    required this.required,
  });

  String name;
  String dataType;
  bool required;
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
