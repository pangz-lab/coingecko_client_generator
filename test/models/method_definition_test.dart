import 'dart:io';

import 'package:coingecko_client_generator/models/method_definition.dart';
import 'package:coingecko_client_generator/models/parameter_definition.dart';
import 'package:test/test.dart';

void main() {
  final methodTemplatePath = 'lib/templates/endpoint_template.method';
  group('MethodDefinition test', () {
    MethodDefinition? sut;
    var template = File(methodTemplatePath);
    var methodTemplate = template.readAsStringSync();

    test('create definition without parameters', () {
      sut = MethodDefinition(
        template: methodTemplate,
        name: "callTest",
      );
      var content = sut!.toString();
      expect(content, '''
  Future<Response> callTest() async {
    _path = _baseEndpoint;
    return await send(_path);
  }''');
    });

    test('create definition with parameters', () {
      sut = MethodDefinition(
          template: methodTemplate,
          name: "callTest",
          parameters: {
            'name': ParameterDefinition(
                name: 'name', dataType: 'String', required: true),
            'name_key': ParameterDefinition(
                name: 'name_key', dataType: 'String', required: false),
          });
      var content = sut!.toString();
      expect(content, '''
  Future<Response> callTest({
    required String name,
    String? nameKey
  }) async {
    _path = _baseEndpoint;
    List<String> keyValueList = [];
    keyValueList.addAll([
      setQueryKeyValue('name', name),
      setQueryKeyValue('name_key', nameKey)
    ]);
    keyValueList.removeWhere((e) => e.trim().isEmpty);
    _path += keyValueList.join('&');
    return await send(_path);
  }''');
    });
  });
}
