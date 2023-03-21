import 'package:coingecko_client_generator/coingecko_client_generator.dart';
import 'package:coingecko_client_generator/services/api_definition_parser.dart';
import 'package:test/test.dart';

void main() {
  group('ApiDefinitionParser test', () {
    var sut = CoinGeckoClientGenerator(
      ApiDefinitionParser('coingecko-api.v3.json'),
      'lib/templates/endpoint_template.class',
      'lib/templates/endpoint_template.method'
    );

    
    test('generate test', () async {
      await sut.generate();
    });
  });
//   final classTemplate = '''import 'dart:html';

// import 'package:coingecko_client/src/endpoints/endpoint_base.dart';

// class CLASS_NAME extends EndpointBase implements EndpointInterface {
//   String _baseEndpoint = "BASE_ENDPOINT";
//   @override
//   String get baseEndpoint => _baseEndpoint;

//   Future<HttpRequest> price(PARAMETERS) async {
//     _baseEndpoint = "\$_baseEndpoint/price";
//     return await send(baseEndpoint);
//   }
// }''';
  // test('getApiDefinition', () {
  //   var definition = sut.generate()
  // });

//   test('getClassTemplate', () {
//     var content = getClassTemplate('lib/templates/endpoint_template.class');
//     expect(content, classTemplate);
//   });

//   test('defineClassContent without parameters', () {
//     var definition = defineClassContent(
//       classDefinition: ClassDefinition(
//         name: "SimpleEndpoint",
//         baseEndpoint: "/simple",
//         parameters: []
//       ),
//       template: classTemplate
//     );
//     expect(definition, '''import 'dart:html';

// import 'package:coingecko_client/src/endpoints/endpoint_base.dart';

// class SimpleEndpoint extends EndpointBase implements EndpointInterface {
//   String _baseEndpoint = "/simple";
//   @override
//   String get baseEndpoint => _baseEndpoint;

//   Future<HttpRequest> price() async {
//     _baseEndpoint = "\$_baseEndpoint/price";
//     return await send(baseEndpoint);
//   }
// }''');
//   });

//   test('defineClassContent with parameters', () {
//     var definition = defineClassContent(
//       classDefinition: ClassDefinition(
//         name: "SimpleEndpoint",
//         baseEndpoint: "/simple",
//         parameters: [
//           ParameterDefinition(dataType: "String", name: "param0", required: true),
//           ParameterDefinition(dataType: "String", name: "param1", required: false),
//           ParameterDefinition(dataType: "bool", name: "param2", required: false)
//         ]
//       ),
//       template: classTemplate
//     );
//     expect(definition, '''import 'dart:html';

// import 'package:coingecko_client/src/endpoints/endpoint_base.dart';

// class SimpleEndpoint extends EndpointBase implements EndpointInterface {
//   String _baseEndpoint = "/simple";
//   @override
//   String get baseEndpoint => _baseEndpoint;

//   Future<HttpRequest> price({
//     required String param0,
//     String? param1,
//     bool? param2
//   }) async {
//     _baseEndpoint = "\$_baseEndpoint/price";
//     return await send(baseEndpoint);
//   }
// }''');

//   });

//   test('generateClassFile', () {
//     const className = 'test/test_endpoint.test';
//     if(File(className).existsSync()) {
//       File(className).deleteSync();
//     }
//     generateClassFile(className, defineClassContent(
//       classDefinition: ClassDefinition(
//         name: "SimpleEndpoint",
//         baseEndpoint: "/simple",
//         parameters: [
//           ParameterDefinition(dataType: "String", name: "param0", required: true),
//           ParameterDefinition(dataType: "String", name: "param1", required: false),
//           ParameterDefinition(dataType: "bool", name: "param2", required: false)
//         ]
//       ),
//       template: classTemplate
//     ));
//     expect(File(className).existsSync(), true);
//   });
}
