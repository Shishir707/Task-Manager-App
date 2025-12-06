class MyUrls {
  static const String _baseUrl = "http://35.73.30.144:2005/api/v1";

  static const String registration = "$_baseUrl/Registration";
  static const String login = "$_baseUrl/Login";
  static const String createTask = "$_baseUrl/createTask";
  static const String newTasksUrl = "$_baseUrl/listTaskByStatus/New";
  static const String progressTasksUrl = "$_baseUrl/listTaskByStatus/Progress";
  static const String cancelledTasksUrl =
      "$_baseUrl/listTaskByStatus/Cancelled";
  static const String completedTasksUrl =
      "$_baseUrl/listTaskByStatus/Completed";
  static const String totalTaskUrl = "$_baseUrl/taskStatusCount";

  static String updateTaskUrl(String id, String status) =>
      "$_baseUrl/updateTaskStatus/$id/$status";

  static String deleteTaskUrl(String id) => "$_baseUrl/deleteTask/$id";

  static const String updateProfile = "$_baseUrl/ProfileUpdate";
}
