// import 'package:driver_app/helper/constants.dart';
// import 'package:driver_app/network/response/task.dart';
// import 'package:driver_app/network/response/tasks_response.dart';
// import 'package:flutter/material.dart';
//
// class HomeChangeNotifier extends ChangeNotifier {
//   bool _isPaginationLoading = false;
//   // List<Task> _allTasks = [];
//   List<Task> tasks = [];
//   List<Task> newTask = [];
//   bool get isPaginationLoading => _isPaginationLoading;
//   set isPaginationLoading(bool isPaginationLoading) {
//     _isPaginationLoading = isPaginationLoading;
//     notifyListeners();
//   }
//
//   TasksResponse _response;
//
//   String nextPageUrl;
//   void addItems(TasksResponse response, bool isNextPageUrl) {
//     if (response != null && response.tasks != null) {
//       if (_response == null || !isNextPageUrl) {
//         _response = response;
//         this.tasks = [];
//         this.newTask = [];
//       } else {
//         _response.tasks.tasks.addAll(response.tasks.tasks);
//       }
//       // this._allTasks.addAll(response.tasks.getAllTasks());
//       this.tasks.addAll(response.tasks.getAcceptedTask());
//       this.newTask.addAll(response.tasks.getNewdTask());
//       nextPageUrl = response.tasks.nextPageUrl;
//     } else {
//       if (!isNextPageUrl) {
//         this.tasks = [];
//         this.newTask = [];
//       }
//     }
//     debugPrint("$APP_TAG****HomeChangeNotifier addItems()");
//     _isPaginationLoading = false;
//     notifyListeners();
//   }
//
//   void updateItem(Task task) {
//     if (_response != null &&
//         _response.tasks != null &&
//         task != null &&
//         task.order != null &&
//         task.order.isNotEmpty) {
//       _response.tasks.tasks.asMap().forEach((index, value) => {
//             if (task.id == _response.tasks.tasks[index].id)
//               {_response.tasks.tasks[index] = task}
//           });
//
//       // this._allTasks = response.tasks.getAllTasks() ?? [];
//       this.tasks = _response.tasks.getAcceptedTask() ?? [];
//       this.newTask = _response.tasks.getNewdTask() ?? [];
//     }
//     debugPrint("$APP_TAG HomeChangeNotifier updateItem()");
//     notifyListeners();
//   }
//
//   void reset() {
//     tasks = [];
//     newTask = [];
//     notifyListeners();
//   }
// }
