import 'package:coingecko_client_generator/coingecko_client_generator.dart';
import 'package:coingecko_client_generator/services/api_definition_parser.dart';
import 'package:test/test.dart';

void main() {
  group('ApiDefinitionParser test', () {
    var generatedClassDir = 'generated_class';
    var sut = CoinGeckoClientGenerator(
      ApiDefinitionParser('coingecko-api.v3.json'),
      'lib/templates/endpoint_template.class',
      'lib/templates/endpoint_template.method',
      generatedClassDir
    );
    
    test('generate test', () async {
      await sut.generate();
    });
  });
}
