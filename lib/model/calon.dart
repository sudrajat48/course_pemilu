class Calon {
  Calon({
    required this.id,
    required this.nomor,
    required this.nama,
    required this.partai,
    required this.foto,
    required this.idPemilu,
  });

  String id;
  String nomor;
  String nama;
  String partai;
  String foto;
  String idPemilu;

  factory Calon.fromJson(Map<String, dynamic> json) => Calon(
        id: json["id"],
        nomor: json["nomor"],
        nama: json["nama"],
        partai: json["partai"],
        foto: json["foto"],
        idPemilu: json["id_pemilu"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nomor": nomor,
        "nama": nama,
        "partai": partai,
        "foto": foto,
        "id_pemilu": idPemilu,
      };
}
