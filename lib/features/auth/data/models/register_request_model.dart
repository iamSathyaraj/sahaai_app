class RegisterRequestModel {

  final String fullName;
  final String email;
  final String phone;
  final String userName;
  final String password;
  final String confirmPassword;

  RegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.userName,
    required this.password, 
    required this.confirmPassword
  });

  Map <String, dynamic> toJson() =>{
    "fullName":fullName,
    "email":email,
    "phone":phone,
    "userName":userName,
    "password":password,
    "confirmPassword":confirmPassword
    
  };

}
