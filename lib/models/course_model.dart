/**
 *
 * Modelo de una asignatura de Swad
 *
 */
class Course {

  String?  _courseCode ,  _userRole , _shortName , _fullName;

  Course( this._courseCode, this._userRole, this._shortName, this._fullName);

  @override
  String toString() {
    return 'Course{userRole: $_userRole, shortName: $_shortName, fullName: $_fullName}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          runtimeType == other.runtimeType &&
          _userRole == other._userRole &&
          _shortName == other._shortName &&
          _fullName == other._fullName;


  String? get userRole => _userRole;

  @override
  int get hashCode =>
      _userRole.hashCode ^ _shortName.hashCode ^ _fullName.hashCode;

  get shortName => _shortName;

  get fullName => _fullName;


  String? get courseCode => _courseCode;

  Course.fromJson(Map<String, dynamic> json){
    _userRole = json['userRole'];
    _shortName = json['courseShortName'];
    _fullName = json['courseFullName'];
    _courseCode= json['courseCode'];
  }

}