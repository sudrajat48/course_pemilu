class Pemilu {
  Pemilu({
    required this.id,
    required this.nama,
    required this.tahun,
    required this.status,
  });

  String id;
  String nama;
  String tahun;
  String status;

  factory Pemilu.fromJson(Map<String, dynamic> json) => Pemilu(
        id: json["id"],
        nama: json["nama"],
        tahun: json["tahun"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "tahun": tahun,
        "status": status,
      };
}
