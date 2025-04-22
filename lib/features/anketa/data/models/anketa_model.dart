class AnketaModel {
  final String text;

  AnketaModel({required this.text});

  factory AnketaModel.fromJson(Map<String, dynamic> json) {
    return AnketaModel(
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}
