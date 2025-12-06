class UserEntity {
  final int id;  
  final String fullName;     
  final String username;
  final String email;
  final String phone;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    required this.phone,
  });
}