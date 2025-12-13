class Respostas {
  int? id;
  String? description;
  int? perguntaId;
  String? createdAt;
  String? updatedAt;

  Respostas(
      {this.id,
      this.description,
      this.perguntaId,
      this.createdAt,
      this.updatedAt});

  Respostas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    perguntaId = json['perguntaId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['perguntaId'] = perguntaId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}