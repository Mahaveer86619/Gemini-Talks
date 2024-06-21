import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_talks/features/gen/model/history/save_chat_history.dart';
import 'package:gemini_talks/features/gen/model/history/save_creative_history.dart';
import 'package:gemini_talks/features/gen/model/resp/chat_hist_resp_model.dart';
import 'package:gemini_talks/features/gen/model/resp/creative_hist_resp_model.dart';
import 'package:http/http.dart' as http;
import 'package:gemini_talks/core/resources/data_state.dart';

class HistoryRepository {
  Future<DataState<void>> saveCreativeHistory(
    SaveCreativeHistoryModel history,
    // String tokenKey,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${dotenv.get('BASE_URL')}/creativeHistory',
        ),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $tokenKey',
        },
        body: history.toJson(),
      );

      if (response.statusCode != 201) {
        return DataFailure(response.body, response.statusCode);
      }

      return const DataSuccess(null);
    } catch (e) {
      return DataFailure(e.toString(), -1);
    }
  }

  Future<DataState<void>> saveChatHistory(
    SaveChatHistoryModel history,
    // String tokenKey,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${dotenv.get('BASE_URL')}/chatHistory',
        ),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $tokenKey',
        },
        body: history.toJson(),
      );

      if (response.statusCode != 201) {
        return DataFailure(response.body, response.statusCode);
      }

      return const DataSuccess(null);
    } catch (e) {
      return DataFailure(e.toString(), -1);
    }
  }

  Future<DataState<ChatHistRespModel>> getChatHistory(
    String id,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${dotenv.get('BASE_URL')}/history',
        ),
        headers: {
          'Content-Type': 'application/json',
          'id': id,
          'type': 'chat',
          // 'Authorization': 'Bearer $tokenKey',
        },
      );

      if (response.statusCode != 200) {
        return DataFailure(response.body, response.statusCode);
      }

      return DataSuccess(
        ChatHistRespModel.fromJson(
          jsonDecode(response.body),
        ),
      );
    } catch (e) {
      return DataFailure(e.toString(), -1);
    }
  }

  Future<DataState<CreativeHistRespModel>> getCreativeHistory(
    String id,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${dotenv.get('BASE_URL')}/history',
        ),
        headers: {
          'Content-Type': 'application/json',
          'id': id,
          'type': 'creative',
          // 'Authorization': 'Bearer $tokenKey',
        },
      );

      if (response.statusCode != 200) {
        return DataFailure(response.body, response.statusCode);
      }

      return DataSuccess(
        CreativeHistRespModel.fromJson(
          jsonDecode(response.body),
        ),
      );
    } catch (e) {
      return DataFailure(e.toString(), -1);
    }
  }

  Future<DataState<List<CreativeHistRespModel>>> getAllCreativeHistory(
    String userUid,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${dotenv.get('BASE_URL')}/history',
        ),
        headers: {
          'Content-Type': 'application/json',
          'user_uid': userUid,
          'type': 'creative',
          // 'Authorization': 'Bearer $tokenKey',
        },
      );

      if (response.statusCode != 200) {
        return DataFailure(response.body, response.statusCode);
      }

      final data = (jsonDecode(response.body) as List)
          .map((history) => CreativeHistRespModel.fromJson(history))
          .toList();

      return DataSuccess(data);
    } catch (e) {
      return DataFailure(e.toString(), -1);
    }
  }

  Future<DataState<List<ChatHistRespModel>>> getAllChatHistory(
    String userUid,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${dotenv.get('BASE_URL')}/history',
        ),
        headers: {
          'Content-Type': 'application/json',
          'user_uid': userUid,
          'type': 'chat',
          // 'Authorization': 'Bearer $tokenKey',
        },
      );

      if (response.statusCode != 200) {
        return DataFailure(response.body, response.statusCode);
      }

      final data = (jsonDecode(response.body) as List)
          .map((history) => ChatHistRespModel.fromJson(history))
          .toList();

      return DataSuccess(data);
    } catch (e) {
      return DataFailure(e.toString(), -1);
    }
  }
}
