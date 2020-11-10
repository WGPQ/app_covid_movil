class Provincia {
  int id;
  String nombre;
  String imageurl;
  Provincia({this.id, this.nombre, this.imageurl});

   factory Provincia.fromJson(Map<String, dynamic> json) {
    return Provincia(
      id: json['id'],
      nombre: json['nombre'],
      imageurl: json['imageurl']
    );
  }
}
