// 1. Adicione a biblioteca http no seu pubspec.yaml:
// dependencies:
//   http: ^1.2.1

import 'dart:convert';
import 'package:http/http.dart' as http;

// Função assíncrona para buscar um post na API
Future<void> buscaPost() async {
  // URL da API que será acessada
  var dia = DateTime.now();
  var diaAntes;

  if (dia.weekday == 7)
    diaAntes = dia.subtract(Duration(days: 2));
  else
    diaAntes = dia.subtract(Duration(days: 1));

  var mes = diaAntes.month;
  var numero = diaAntes.day;
  var ano = diaAntes.year;

  var url = Uri.https(
      'olinda.bcb.gov.br',
      '/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarDia(dataCotacao=@dataCotacao)',
      {
        '@dataCotacao': '\'$mes-$numero-$ano\'',
        '\$top': '100',
        '\$format': 'json',
        '\$select': 'cotacaoCompra'
      });

  try {
    // 2. Faz a requisição GET e espera a resposta
    var response = await http.get(url);

    // 3. Verifica se a requisição foi bem-sucedida
    if (response.statusCode == 200) {
      // 4. Decodifica o JSON da resposta
      var jsonBody = json.decode(response.body);

      // 5. Extrai e imprime o valor que queremos
      var titulo = jsonBody['value'][0]['cotacaoCompra'];
      print(titulo);
      //print('Título do post: $titulo');
    } else {
      print('Erro ao acessar a API. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    // 6. Trata possíveis erros de conexão
    print('Ocorreu um erro na requisição: $e');
  }
}

void main() {
  buscaPost();
}
