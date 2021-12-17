import 'package:flutter/material.dart';
import 'package:flutter_http_request/widgets/example/example_model.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    final model = ExampleWidgetModel();
    return Scaffold(
      body: SafeArea(
        child: ExampleWidgetProvaider(
          model: model,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              _ReloadButton(),
              _CreatPost(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: _PostWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReloadButton extends StatelessWidget {
  const _ReloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          ExampleWidgetProvaider.read(context)?.model.reloadPosts(),
      child: const Text("Обновить посты"),
    );
  }
}

class _CreatPost extends StatelessWidget {
  const _CreatPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => ExampleWidgetProvaider.read(context)?.model.createPost(),
      child: const Text("Создать пост"),
    );
  }
}

class _PostWidget extends StatelessWidget {
  const _PostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount:
            ExampleWidgetProvaider.watch(context)?.model.posts.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return _PostRowWidget(
            index: index,
          );
        });
  }
}

class _PostRowWidget extends StatelessWidget {
  final int index;
  const _PostRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = ExampleWidgetProvaider.read(context)!.model.posts[index];
    return Column(
      children: [
        Text(post.id.toString()),
        const SizedBox(
          height: 10,
        ),
        Text(post.title),
        const SizedBox(
          height: 10,
        ),
        Text(post.body),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
