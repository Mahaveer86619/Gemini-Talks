import 'package:gemini_talks/core/common/models/creative_template_model.dart';
import 'package:gemini_talks/core/common/models/history_model.dart';

List<CreativeTemplateModel> creativeTemplates = [
  const CreativeTemplateModel(
    headline: 'Poem',
    prompt: 'Write an poem on cats.',
  ),
  const CreativeTemplateModel(
    headline: 'Email',
    prompt: 'Write an email for pay raise.',
  ),
  const CreativeTemplateModel(
    headline: 'Letter',
    prompt: 'Write a letter to your friend.',
  ),
  const CreativeTemplateModel(
    headline: 'Memo',
    prompt: 'Write a memo to your boss.',
  ),
];

List<HistoryModel> historyList = [
  HistoryModel(
    id: '1',
    title: 'write a poem on cats',
    isChat: false,
  ),
  HistoryModel(
    id: '2',
    title: 'write an email for pay raise',
    isChat: false,
  ),
  HistoryModel(
    id: '3',
    title: 'Hello, how are you?',
    isChat: true,
  ),
  HistoryModel(
    id: '4',
    title: 'Teach me how to program',
    isChat: true,
  ),
  HistoryModel(
    id: '5',
    title: 'write a letter to your friend',
    isChat: false,
  ),
];
