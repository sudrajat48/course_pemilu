class Voting {
  Voting({
    required this.id,
    required this.idPemilu,
    required this.idCalon,
    required this.nik,
  });

  String id;
  String idPemilu;
  String idCalon;
  String nik;

  factory Voting.fromJson(Map<String, dynamic> json) => Voting(
        id: json["id"],
        idPemilu: json["id_pemilu"],
        idCalon: json["id_calon"],
        nik: json["nik"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pemilu": idPemilu,
        "id_calon": idCalon,
        "nik": nik,
      };
}
