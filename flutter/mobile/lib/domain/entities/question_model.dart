class Pergunta {
  int? id;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;

  Pergunta(
      {this.id, this.title, this.description, this.createdAt, this.updatedAt});

  Pergunta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}