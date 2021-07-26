import 'dart:convert';

import '../../../fixtures/fixture_reader.dart';

final imageString = json.decode(fixture('dummy_news.json'))['base64Image'];
final imageBytes = base64.decode(imageString);
