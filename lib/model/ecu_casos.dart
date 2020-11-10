class Casoscovid {
  int id;
  var fecha;
  int confirmados;
  int fallecidos;
  int recuperados;
  Casoscovid(
      {this.id,
      this.fecha,
      this.confirmados,
      this.fallecidos,
      this.recuperados});
      
  factory Casoscovid.fromJson(Map<String, dynamic> json) {
    return Casoscovid(
        id: json['id'],
        fecha: json['fecha'],
        confirmados: json['confirmados'],
        fallecidos: json['fallecidos'],
        recuperados: json['recuperados']);
  }
}
