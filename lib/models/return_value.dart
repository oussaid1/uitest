class ReturnValue<T> {
  String? msg;
  String? error;
  bool success;
  T? value;
  ReturnValue({this.msg, this.error, required this.success, this.value});
  ReturnValue.success(this.value)
      : msg = 'Success',
        success = true;
  ReturnValue.error(this.error) : success = false;
}
