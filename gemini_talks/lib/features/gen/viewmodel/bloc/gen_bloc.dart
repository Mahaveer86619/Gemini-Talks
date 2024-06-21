import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gemini_talks/core/resources/data_state.dart';
import 'package:gemini_talks/features/gen/model/chat_item_model.dart';
import 'package:gemini_talks/features/gen/model/gen/chat_request_model.dart';
import 'package:gemini_talks/features/gen/model/history/save_chat_history.dart';
import 'package:gemini_talks/features/gen/model/history/save_creative_history.dart';
import 'package:gemini_talks/features/gen/model/resp/chat_hist_resp_model.dart';
import 'package:gemini_talks/features/gen/model/resp/creative_hist_resp_model.dart';
import 'package:gemini_talks/features/gen/model/template_model.dart';
import 'package:gemini_talks/features/gen/repository/gen_repository.dart';
import 'package:gemini_talks/features/gen/repository/history_repository.dart';
import 'package:gemini_talks/features/gen/repository/template_repository.dart';

part 'gen_event.dart';
part 'gen_state.dart';

class GenBloc extends Bloc<GenEvent, GenState> {
  final GenRepository _genRepository;
  final HistoryRepository _historyRepository;
  final TemplateRepository _templateRepository;

  GenBloc({
    required GenRepository genRepository,
    required HistoryRepository historyRepository,
    required TemplateRepository templateRepository,
  })  : _genRepository = genRepository,
        _historyRepository = historyRepository,
        _templateRepository = templateRepository,
        super(GenInitial()) {
    on<GenEvent>((_, emit) => emit(Loading()));
    on<FetchAll>((event, emit) => _onFetchAll);
    on<LoadHistory>((event, emit) => _onLoadHistory);
    on<GenCreative>((event, emit) => _onGenCreative);
    on<GenChat>((event, emit) => _onGenChat);
    on<SaveChatHistory>((event, emit) => _onSaveChatHistory);
    on<SaveCreativeHistory>((event, emit) => _onSaveCreativeHistory);
  }

  Future<void> _onFetchAll(FetchAll event, Emitter<GenState> emit) async {
    try {
      // get token and pass here
      final templatesResp = await _templateRepository.getTemplates();
      final chatHistoryResp = await _historyRepository.getAllChatHistory(
        'abc',
      );
      final creativeHistoryResp =
          await _historyRepository.getAllCreativeHistory(
        'abc',
      );

      if (templatesResp is DataSuccess &&
          chatHistoryResp is DataSuccess &&
          creativeHistoryResp is DataSuccess) {
        emit(
          Loaded(
            chatHistories: chatHistoryResp.data!,
            creativeHistories: creativeHistoryResp.data!,
            templates: templatesResp.data!,
          ),
        );
      } else if (templatesResp is DataFailure) {
        emit(Error(templatesResp.error!));
      } else if (chatHistoryResp is DataFailure) {
        emit(Error(chatHistoryResp.error!));
      } else if (creativeHistoryResp is DataFailure) {
        emit(Error(creativeHistoryResp.error!));
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> _onLoadHistory(LoadHistory event, Emitter<GenState> emit) async {
    //* Only the chat history is loded, as the creative history can just be loaded client side
    try {
      final resp = await _historyRepository.getChatHistory(
        event.id,
      );

      if (resp is DataSuccess) {
        emit(ChatGenLoaded(resp.data!));
      } else {
        emit(Error(resp.error!));
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> _onGenCreative(GenCreative event, Emitter<GenState> emit) async {
    try {
      final resp = await _genRepository.generateCreativeResponse(
        event.prompt,
      );

      if (resp is DataSuccess) {
        emit(GeneratedCreativeResp(resp.data!));
      } else {
        emit(Error(resp.error!));
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> _onGenChat(GenChat event, Emitter<GenState> emit) async {
    try {
      final resp = await _genRepository.generateChatResponse(
        event.chatRequestModel,
      );

      event.chatRequestModel.history
        ..add(
          ChatItemModel(
            true,
            event.chatRequestModel.history.last.message,
            DateTime.now().toIso8601String(),
          ),
        )
        ..add(
          ChatItemModel(
            false,
            resp.data!,
            DateTime.now().toIso8601String(),
          ),
        );

      if (resp is DataSuccess) {
        emit(GeneratedChatResp(event.chatRequestModel.history));
      } else {
        emit(Error(resp.error!));
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> _onSaveChatHistory(
      SaveChatHistory event, Emitter<GenState> emit) async {
    try {
      final resp = await _historyRepository.saveChatHistory(
        event.saveChatHistoryModel,
      );

      if (resp is DataSuccess) {
        emit(const Success('Chat history saved'));
      } else {
        emit(Error(resp.error!));
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> _onSaveCreativeHistory(
      SaveCreativeHistory event, Emitter<GenState> emit) async {
    try {
      final resp = await _historyRepository.saveCreativeHistory(
        event.saveCreativeHistoryModel,
      );

      if (resp is DataSuccess) {
        emit(const Success('Saved'));
      } else {
        emit(Error(resp.error!));
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
