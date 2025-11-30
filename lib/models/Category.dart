class Category {
  final int id;
  final String namaKategori;
  final String? createdAt;
  final String? updatedAt;

  Category({
    required this.id,
    required this.namaKategori,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      namaKategori: json['nama_kategori'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_kategori': namaKategori,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}