import 'package:coingecko_client_generator/models/api_endpoint_definition.dart';
import 'package:coingecko_client_generator/services/api_definition_parser.dart';
import 'package:test/test.dart';

void main() {
  group('ApiDefinitionParser test', () {
    var sut = ApiDefinitionParser('coingecko-api.v3.json');
    test('test definition object', () {
      var pingEndpoint = sut.apiDefinitionMap["/ping"] as ApiEndpointDefinition;
      var simpleTokenPriceEndpoint =
          sut.apiDefinitionMap["/simple/token_price/{id}"]
              as ApiEndpointDefinition;
      expect(pingEndpoint.path, "/ping");
      expect(pingEndpoint.parameters, {});
      expect(pingEndpoint.summary, "Check API server status");

      expect(simpleTokenPriceEndpoint.path, "/simple/token_price/{id}");
      expect(simpleTokenPriceEndpoint.summary,
          "Get current price of tokens (using contract addresses) for a given platform in any other currency that you need.");
      expect(simpleTokenPriceEndpoint.parameters["id"]!.name, "id");
      expect(simpleTokenPriceEndpoint.parameters["id"]!.description,
          "The id of the platform issuing tokens (See asset_platforms endpoint for list of options)");
      expect(simpleTokenPriceEndpoint.parameters["id"]!.required, true);
      expect(simpleTokenPriceEndpoint.parameters["id"]!.type, "String");
    });

    test('check endpoint group', () {
      var endpointGroup = sut.endpointGroup;
      expect(
        endpointGroup["simple"],
        [
          '/simple/price',
          '/simple/token_price/{id}',
          '/simple/supported_vs_currencies'
        ]
      );
    });
  });
}
