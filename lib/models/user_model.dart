class UserModel {
  final int id;
  final String name;
  final String email;
  final String? noWa;
  final String? alamat;
  final String? fotoProfil;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.noWa,
    this.alamat,
    this.fotoProfil,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      noWa: json['no_wa'],
      alamat: json['alamat'],
      fotoProfil: json['foto_profil'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'no_wa': noWa,
      'alamat': alamat,
      'foto_profil': fotoProfil,
    };
  }
}
