class ApiEndpoints {
  static const String baseUrl = '3.108.228.127';
  static const String dataSocket = 'ws://3.108.228.127:3001';
  static const String requestAccessAdmin = 'bullion_owner/request_access';
  static const String requestAccessUser = 'end_user/request_access';
  static const String usersList = 'bullion_owner/get_all_end_users_by_bullion_owner_id';
  static const String deleteUser = 'bullion_owner/remove_end_user';
  static const String addUser = 'bullion_owner/add_end_user';
  static const String updateValues = 'bullion_owner/set_gold_and_silver_prices';
}
