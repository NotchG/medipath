class ChatCompletionResponse {
  final String? id;
  final String? object;
  final int? created;
  final String? model;
  final List<Choice>? choices;
  final String? systemFingerprint;

  ChatCompletionResponse({
    this.id,
    this.object,
    this.created,
    this.model,
    this.choices,
    this.systemFingerprint,
  });

  factory ChatCompletionResponse.fromJson(Map<String, dynamic> json) {
    return ChatCompletionResponse(
      id: json['id'],
      object: json['object'],
      created: json['created'],
      model: json['model'],
      choices: (json['choices'] as List?)
          ?.map((e) => Choice.fromJson(e))
          .toList(),
      systemFingerprint: json['system_fingerprint'],
    );
  }
}

class Choice {
  final int? index;
  final Message? message;
  final dynamic logprobs;
  final String? finishReason;

  Choice({
    this.index,
    this.message,
    this.logprobs,
    this.finishReason,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      index: json['index'],
      message: json['message'] != null ? Message.fromJson(json['message']) : null,
      logprobs: json['logprobs'],
      finishReason: json['finish_reason'],
    );
  }
}

class Message {
  final String? role;
  final String? content;

  Message({this.role, this.content});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      role: json['role'],
      content: json['content'],
    );
  }
}