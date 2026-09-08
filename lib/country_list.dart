import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchCountries() async {
  
 List<String> defaultCountries = [
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
    return defaultCountries;
}
