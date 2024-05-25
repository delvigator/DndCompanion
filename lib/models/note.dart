class Note{
  final String title;
  final String text;
  final String? category;

  Note({required this.title, required this.text, this.category});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
      'category': category,
    };
  }

  factory Note.fromJson(Map<String, dynamic> map) {
    return Note(
      title: map['title'] ?? "",
      text: map['text'] ?? "",
      category: map['category']  ?? "",
    );
  }
}