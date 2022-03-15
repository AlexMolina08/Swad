///
/// Modelo de un Usuario Swad
/// Contiene toda la información disponible del usuario
/// basándose en los datos recibidos de la API
/// Contine además el parametro userRole con valores
/// 0, 1, 2, o 3 (unkown , guest , student y teacher respectivamente)
///
class User {
  String? _userCode,
      _nickname,
      _firstName,
      _surName1,
      _surName2,
      _photoUrl,
      _userRole,
      _userID; // DNI del usuario


  ///
  /// Crear Usuario a partir de un Map
  ///
  User.fromJson(Map<String, dynamic> userJsonData) {
    _userCode = userJsonData['userCode'];
    _nickname = userJsonData['userNickname'];
    _userID = userJsonData['userID'];
    _firstName = userJsonData['userFirstname'];
    _surName1 = userJsonData['userSurname1'];
    _surName2 = userJsonData['userSurname2'];
    _photoUrl = userJsonData['userPhoto'];

  }

  User(
      {required String userCode,
      required String nickname,
      required String firstName,
      required String surName1,
      required String surName2,
      required String photoUrl,
      required String userRole ,
      required String userID})
      : _nickname = nickname ,
        _userRole = userCode,
        _userCode = userCode ,
        _firstName = firstName ,
        _surName1 = surName1 ,
        _surName2 = surName2 ,
        _userID = userID;

  get userID => _userID;

  get userRole => _userRole;

  get photoUrl => _photoUrl;

  get surName2 => _surName2;

  get surName1 => _surName1;

  get firstName => _firstName;

  get nickname => _nickname;

  get userCode => _userCode;
}
