import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchCountries() async {
  const String apiKey = 'MI_API_KEY';
  const String url = 'https://api.countrystatecity.in/v1/countries';

  final List<String> defaultCountries = [
    'Ecuador',
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
    'India',
    'China',
    'Japan',
    'Brazil',
  ];

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-CSCAPI-KEY': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // Extraer 'name' de cada objeto del array
      return data.map((country) => country['name'] as String).toList();
    }
  } catch (e) {
    // Si la red falla, la key es inválida o el parseo da error
  }

  return defaultCountries;
}
