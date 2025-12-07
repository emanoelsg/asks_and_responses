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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}