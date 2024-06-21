import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_talks/features/gen/model/gen/chat_request_model.dart';
import 'package:http/http.dart' as http;
import 'package:gemini_talks/core/resources/data_state.dart';

class GenRepository {
  Future<DataState<String>> generateCreativeResponse(
    String prompt,
    // String tokenKey,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${dotenv.get('BASE_URL')}/creative',
        ),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $tokenKey',
        },
        body: jsonEncode({
          'prompt': prompt,
        }),
      );

      if (response.statusCode != 200) {
        return DataFailure(response.body, response.statusCode);
      }

      return DataSuccess(response.body);

    } catch (e) {
      return DataFailure(e.toString(), -1);
    }
  }

  Future<DataState<String>> generateChatResponse(
    ChatRequestModel chatRequestModel,
    // String tokenKey,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${dotenv.get('BASE_URL')}/chat',
        ),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $tokenKey',
        },
        body: chatRequestModel.toJson(),
      );

      if (response.statusCode != 200) {
        return DataFailure(response.body, response.statusCode);
      }

      return DataSuccess(response.body);

    } catch (e) {
      return DataFailure(e.toString(), -1);
    }
  }
}
