import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xml2json/xml2json.dart';
import 'package:untitled/utilities/utils.dart' as utils;

/**
 *
 * Datos del usuario .
 * Los parámetros coinciden con lo obtenido de la API
 *
 */
class Auth {

  String? _userCode;
  String? _wsKey;
  String? _userNickname;
  String? _userID;
  String? _userSurname1;
  String? _userSurname2;
  String? _userFirstname;
  String? _userPhoto;
  String? _userBirthday;
  String? _userRole;

  Auth(
      {String? userCode,
        String? wsKey,
        String? userNickname,
        String? userID,
        String? userSurname1,
        String? userSurname2,
        String? userFirstname,
        String? userPhoto,
        String? userBirthday,
        String? userRole}) {
    if (userCode != null) {
      this._userCode = userCode;
    }
    if (wsKey != null) {
      this._wsKey = wsKey;
    }
    if (userNickname != null) {
      this._userNickname = userNickname;
    }
    if (userID != null) {
      this._userID = userID;
    }
    if (userSurname1 != null) {
      this._userSurname1 = userSurname1;
    }
    if (userSurname2 != null) {
      this._userSurname2 = userSurname2;
    }
    if (userFirstname != null) {
      this._userFirstname = userFirstname;
    }
    if (userPhoto != null) {
      this._userPhoto = userPhoto;
    }
    if (userBirthday != null) {
      this._userBirthday = userBirthday;
    }
    if (userRole != null) {
      this._userRole = userRole;
    }
  }

  String? get userCode => _userCode;
  set userCode(String? userCode) => _userCode = userCode;
  String? get wsKey => _wsKey;
  set wsKey(String? wsKey) => _wsKey = wsKey;
  String? get userNickname => _userNickname;
  set userNickname(String? userNickname) => _userNickname = userNickname;
  String? get userID => _userID;
  set userID(String? userID) => _userID = userID;
  String? get userSurname1 => _userSurname1;
  set userSurname1(String? userSurname1) => _userSurname1 = userSurname1;
  String? get userSurname2 => _userSurname2;
  set userSurname2(String? userSurname2) => _userSurname2 = userSurname2;
  String? get userFirstname => _userFirstname;
  set userFirstname(String? userFirstname) => _userFirstname = userFirstname;
  String? get userPhoto => _userPhoto;
  set userPhoto(String? userPhoto) => _userPhoto = userPhoto;
  String? get userBirthday => _userBirthday;
  set userBirthday(String? userBirthday) => _userBirthday = userBirthday;
  String? get userRole => _userRole;
  set userRole(String? userRole) => _userRole = userRole;




  Auth.fromJson(Map<String, dynamic> json) {
    _userCode = json['userCode'];
    _wsKey = json['wsKey'];
    _userNickname = json['userNickname'];
    _userID = json['userID'];
    _userSurname1 = json['userSurname1'];
    _userSurname2 = json['userSurname2'];
    _userFirstname = json['userFirstname'];
    _userPhoto = json['userPhoto'];
    _userBirthday = json['userBirthday'];
    _userRole = json['userRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userCode'] = this._userCode;
    data['wsKey'] = this._wsKey;
    data['userNickname'] = this._userNickname;
    data['userID'] = this._userID;
    data['userSurname1'] = this._userSurname1;
    data['userSurname2'] = this._userSurname2;
    data['userFirstname'] = this._userFirstname;
    data['userPhoto'] = this._userPhoto;
    data['userBirthday'] = this._userBirthday;
    data['userRole'] = this._userRole;
    return data;
  }

  @override
  String toString() {
    return 'Auth{_userCode: $_userCode, _wsKey: $_wsKey, _userNickname: $_userNickname, _userID: $_userID, _userSurname1: $_userSurname1, _userSurname2: $_userSurname2, _userFirstname: $_userFirstname, _userPhoto: $_userPhoto, _userBirthday: $_userBirthday, _userRole: $_userRole}';
  }
}
