/**
 * Enum con las peticiones disponibles a la API
 */
enum SwadRequest{
  loginByUserPasswordKey,
  getCourses,
  getDirectoryTree
}


enum LoginStatus { initialize, loading, success, failed }

// Roles posibles de un user
enum UserRole {unknown,guest,student,teacher}