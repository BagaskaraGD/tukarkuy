class Barang {
  final int id;
  final String nama;
  final String? deskripsi;
  final String? fotoPath;
  final int stok;
  final String kondisi;
  final int? categoryId;

  Barang({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.fotoPath,
    required this.stok,
    required this.kondisi,
    this.categoryId,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    final dynamic cat =
        json['id_kategori'] ?? json['kategori_id'] ?? json['category_id'];
    final int? parsedCat =
        cat is int ? cat : int.tryParse(cat != null ? '$cat' : '');

    return Barang(
      id: json['id'] ?? 0,
      nama: json['nama_bar'] ?? '',
      deskripsi: json['deskripsi_bar'],
      fotoPath: json['foto_bar'],
      stok: json['stok_bar'] is int
          ? json['stok_bar']
          : int.tryParse('${json['stok_bar']}') ?? 0,
      kondisi: json['kondisi'] ?? '',
      categoryId: parsedCat,
    );
  }
}
