class MethodCommentDefinition {
  const MethodCommentDefinition({
    required this.summary,
    required this.description,
    required this.parameterDescription,
  });

  final String summary;
  final String description;
  final String parameterDescription;
  final String _template = '''/// COMMENT_SUMMARY
  /// 
  /// COMMENT_DESCRIPTION
  /// 
COMMENT_PARAMETER_DESCRIPTION''';

  @override
  String toString() {
    return _template.replaceAll('COMMENT_SUMMARY', summary)
      .replaceAll('COMMENT_DESCRIPTION', description)
      .replaceAll('COMMENT_PARAMETER_DESCRIPTION', parameterDescription);
  }
}