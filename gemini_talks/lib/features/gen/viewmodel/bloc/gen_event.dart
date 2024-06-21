part of 'gen_bloc.dart';

sealed class GenEvent extends Equatable {
  const GenEvent();

  @override
  List<Object> get props => [];
}

class FetchAll extends GenEvent {}

class LoadHistory extends GenEvent {
  final String id;
  final String type;

  const LoadHistory(this.id, this.type);

  @override
  List<Object> get props => [id, type];
}

class GenCreative extends GenEvent {
  final String prompt;

  const GenCreative(this.prompt);

  @override
  List<Object> get props => [prompt];
}

class GenChat extends GenEvent {
  final ChatRequestModel chatRequestModel;

  const GenChat(this.chatRequestModel);

  @override
  List<Object> get props => [chatRequestModel];
}

class SaveChatHistory extends GenEvent {
  final SaveChatHistoryModel saveChatHistoryModel;

  const SaveChatHistory(this.saveChatHistoryModel);

  @override
  List<Object> get props => [saveChatHistoryModel];
}

class SaveCreativeHistory extends GenEvent {
  final SaveCreativeHistoryModel saveCreativeHistoryModel;

  const SaveCreativeHistory(this.saveCreativeHistoryModel);

  @override
  List<Object> get props => [saveCreativeHistoryModel];
}
