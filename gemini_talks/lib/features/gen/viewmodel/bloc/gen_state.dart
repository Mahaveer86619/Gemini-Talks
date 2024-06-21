part of 'gen_bloc.dart';

sealed class GenState extends Equatable {
  const GenState();

  @override
  List<Object> get props => [];
}

final class GenInitial extends GenState {}

final class Loading extends GenState {}

final class Loaded extends GenState {
  final List<ChatHistRespModel> chatHistories;
  final List<CreativeHistRespModel> creativeHistories;
  final List<TemplateModel> templates;

  const Loaded({
    required this.chatHistories,
    required this.creativeHistories,
    required this.templates,
  });

  @override
  List<Object> get props => [chatHistories, creativeHistories, templates];
}

final class Success extends GenState {
  final String message;

  const Success(this.message);

  @override
  List<Object> get props => [message];
}

final class Error extends GenState {
  final String error;

  const Error(this.error);

  @override
  List<Object> get props => [error];
}

final class ChatGenLoaded extends GenState {
  final ChatHistRespModel chatHistory;

  const ChatGenLoaded(this.chatHistory);

  @override
  List<Object> get props => [chatHistory];
}

final class GeneratedCreativeResp extends GenState {
  final String creativeResponse;

  const GeneratedCreativeResp(this.creativeResponse);

  @override
  List<Object> get props => [creativeResponse];
}

final class GeneratedChatResp extends GenState {
  final List<ChatItemModel> chatResponse;

  const GeneratedChatResp(this.chatResponse);

  @override
  List<Object> get props => [chatResponse];
}
