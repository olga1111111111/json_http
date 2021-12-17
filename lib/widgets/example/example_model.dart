import 'package:flutter/cupertino.dart';
import 'package:flutter_http_request/domain/api_clients/api_client.dart';
import 'package:flutter_http_request/domain/entity/post.dart';

class ExampleWidgetModel extends ChangeNotifier {
  final client = ApiClient();
  var _posts = <Post>[];
  List<Post> get posts => _posts;

  Future<void> reloadPosts() async {
    final posts = await ApiClient().getPosts();
    _posts += posts;
    notifyListeners();
  }

  void createPost() async {
    final posts = await ApiClient().createPost(title: 'jlkjljljl', body: 'ody');
  }
}

class ExampleWidgetProvaider extends InheritedNotifier {
  final ExampleWidgetModel model;
  const ExampleWidgetProvaider(
      {Key? key, required this.model, required Widget child})
      : super(key: key, notifier: model, child: child);

  static ExampleWidgetProvaider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExampleWidgetProvaider>();
  }

  static ExampleWidgetProvaider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ExampleWidgetProvaider>()
        ?.widget;
    return widget is ExampleWidgetProvaider ? widget : null;
  }
}
