class Infocovid {
  int id;
  int idprov;
  int idcaso;
  var fecha;
  Infocovid({
    this.id,
    this.idprov,
    this.idcaso,
    this.fecha,
  });

  factory Infocovid.fromJson(Map<String, dynamic> json) {
    return Infocovid(
        id: json['id'],
        idprov: json['id_prov'],
        idcaso: json['id_caso'],
        fecha: json['fecha']);
  }
}
