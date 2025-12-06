import '../../domain/entities/user_entity.dart';


class UserModel extends UserEntity {
const UserModel({
required super.id,
required super.fullName,
required super.email,
required super.phone,
required super.username,
});


factory UserModel.fromJson(Map<String, dynamic> json) {
return UserModel(
id: json['userId'],
fullName: json['fullName'] ?? json['full_name'] ?? '',
email: json['email'] ?? '',
phone: json['phone'] ?? '',
username: json['username'] ?? json['userName'] ?? '',
);
}


Map<String, dynamic> toJson() => {
'userId': id,
'fullName': fullName,
'email': email,
'phone': phone,
'username': username,
};
}