class ChangePasswordModel {
  late String username;
  late String oldPassword;
  late String newPassword;

  ChangePasswordModel({
    required this.username,
    required this.oldPassword,
    required this.newPassword,
  });

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    oldPassword = json['old_password'];
    newPassword = json['new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['username'] = username;
    data['old_password'] = oldPassword;
    data['new_password'] = newPassword;
    return data;
  }
}
