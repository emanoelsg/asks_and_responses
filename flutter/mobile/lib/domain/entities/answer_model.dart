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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['perguntaId'] = this.perguntaId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}