import 'dart:io';

import 'package:coingecko_client_generator/coingecko_client_generator.dart';
import 'package:coingecko_client_generator/models/class_definition.dart';
import 'package:coingecko_client_generator/models/method_definition.dart';
import 'package:coingecko_client_generator/models/parameter_definition.dart';
import 'package:test/test.dart';

void main() {
  final classTemplatePath = 'lib/templates/endpoint_template.class';
  final methodTemplatePath = 'lib/templates/endpoint_template.method';
  group('ClassDefinition test', () {
    ClassDefinition? sut;
    var template = File(methodTemplatePath);
    var methodTemplate = template.readAsStringSync();
    template = File(classTemplatePath);
    var classTemplate = template.readAsStringSync();

    test('create definition with single method without parameter', () {
      sut = ClassDefinition(
          template: classTemplate,
          name: "PingEndpoint",
          baseEndpoint: "/ping",
          methods: [MethodDefinition(template: methodTemplate, name: "call")]);
      var content = sut!.toString();
      expect(content,
          '''import 'package:coingecko_client/src/endpoints/endpoint_base.dart';
import 'package:coingecko_client/src/services/http_request_service.dart';
import 'package:http/http.dart';

class PingEndpoint extends EndpointBase implements EndpointInterface {
  final String _baseEndpoint = "/ping";
  String _path = "";
  @override
  String get baseEndpoint => _baseEndpoint;
  PingEndpoint(HttpRequestServiceInterface httpRequestService) : super(httpRequestService);

  Future<Response> call() async {
    _path = _baseEndpoint;
    return await send(_path);
  }
}''');
    });

    test('create definition with single method with parameter', () {
      sut = ClassDefinition(
          template: classTemplate,
          name: "PingEndpoint",
          baseEndpoint: "/ping",
          methods: [
            MethodDefinition(
                template: methodTemplate,
                name: "call",
                parameters: {
                  'param0': ParameterDefinition(
                      dataType: "String", name: "param0", required: true),
                  'param1': ParameterDefinition(
                      dataType: "String", name: "param1", required: false),
                  'param2': ParameterDefinition(
                      dataType: "bool", name: "param2", required: false)
                })
          ]);
      var content = sut.toString();
      expect(content,
          '''import 'package:coingecko_client/src/endpoints/endpoint_base.dart';
import 'package:coingecko_client/src/services/http_request_service.dart';
import 'package:http/http.dart';

class PingEndpoint extends EndpointBase implements EndpointInterface {
  final String _baseEndpoint = "/ping";
  String _path = "";
  @override
  String get baseEndpoint => _baseEndpoint;
  PingEndpoint(HttpRequestServiceInterface httpRequestService) : super(httpRequestService);

  Future<Response> call({
    required String param0,
    String? param1,
    bool? param2
  }) async {
    _path = _baseEndpoint;
    List<String> keyValueList = [];
    keyValueList.addAll([
      setQueryKeyValue('param0', param0),
      setQueryKeyValue('param1', param1),
      setQueryKeyValue('param2', param2)
    ]);
    keyValueList.removeWhere((e) => e.trim().isEmpty);
    _path += keyValueList.join('&');
    return await send(_path);
  }
}''');
    });

    test('create definition with mutiple method with parameter', () {
      sut = ClassDefinition(
          template: classTemplate,
          name: "PingEndpoint",
          baseEndpoint: "/ping",
          methods: [
            MethodDefinition(
                template: methodTemplate,
                name: "call",
                parameters: {
                  'param0': ParameterDefinition(
                      dataType: "String", name: "param0", required: true),
                  'param1': ParameterDefinition(
                      dataType: "String", name: "param1", required: false),
                  'param2': ParameterDefinition(
                      dataType: "bool", name: "param2", required: false)
                }),
            MethodDefinition(
                template: methodTemplate,
                name: "call2",
                parameters: {
                  'param0': ParameterDefinition(
                      dataType: "String", name: "param0", required: true),
                  'param1': ParameterDefinition(
                      dataType: "String", name: "param1", required: false),
                  'param2': ParameterDefinition(
                      dataType: "bool", name: "param2", required: false)
                })
          ]);
      var content = sut.toString();
      expect(content,
          '''import 'package:coingecko_client/src/endpoints/endpoint_base.dart';
import 'package:coingecko_client/src/services/http_request_service.dart';
import 'package:http/http.dart';

class PingEndpoint extends EndpointBase implements EndpointInterface {
  final String _baseEndpoint = "/ping";
  String _path = "";
  @override
  String get baseEndpoint => _baseEndpoint;
  PingEndpoint(HttpRequestServiceInterface httpRequestService) : super(httpRequestService);

  Future<Response> call({
    required String param0,
    String? param1,
    bool? param2
  }) async {
    _path = _baseEndpoint;
    List<String> keyValueList = [];
    keyValueList.addAll([
      setQueryKeyValue('param0', param0),
      setQueryKeyValue('param1', param1),
      setQueryKeyValue('param2', param2)
    ]);
    keyValueList.removeWhere((e) => e.trim().isEmpty);
    _path += keyValueList.join('&');
    return await send(_path);
  }

  Future<Response> call2({
    required String param0,
    String? param1,
    bool? param2
  }) async {
    _path = _baseEndpoint;
    List<String> keyValueList = [];
    keyValueList.addAll([
      setQueryKeyValue('param0', param0),
      setQueryKeyValue('param1', param1),
      setQueryKeyValue('param2', param2)
    ]);
    keyValueList.removeWhere((e) => e.trim().isEmpty);
    _path += keyValueList.join('&');
    return await send(_path);
  }
}''');
    });
  });
}
