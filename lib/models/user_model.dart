///
/// Modelo de un Usuario Swad
/// Contiene toda la información disponible del usuario
/// basándose en los datos recibidos de la API
/// Contine además el parametro userRole con valores
/// 0, 1, 2, o 3 (unkown , guest , student y teacher respectivamente)
///
class User {

  String? userCode ,
      nickname,
      firstName,
      surName1,
      surName2,
      photoUrl ,
      userRole;

  User(
      {this.userCode,
      this.nickname,
      this.firstName,
      this.surName1,
      this.surName2,
      this.photoUrl,
      this.userRole});

}


