import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_talks/features/gen/model/template_model.dart';
import 'package:http/http.dart' as http;
import 'package:gemini_talks/core/resources/data_state.dart';

class TemplateRepository {
  Future<DataState<List<TemplateModel>>> getTemplates() async {
    try {
      final response = await http.post(
        Uri.parse(
          '${dotenv.get('BASE_URL')}/templates',
        ),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $tokenKey',
        },
      );

      if (response.statusCode != 200) {
        return DataFailure(response.body, response.statusCode);
      }

      final data = (jsonDecode(response.body) as List)
          .map((templates) => TemplateModel.fromJson(templates))
          .toList();

      return DataSuccess(data);
    } catch (e) {
      return DataFailure(e.toString(), -1);
    }
  }
}
