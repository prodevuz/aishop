import 'package:bloc_example/imports.dart';

Widget homeView(BuildContext context, bool isLoading) {
  final controller = BlocProvider.of<HomeCubit>(context);
  return Stack(
    children: [
      Scaffold(
        appBar: AppBar(
          title: Text(
            controller.str != '' ? controller.str : 'BLoC example',
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 150),
          padding: const EdgeInsets.all(50),
          height: 300,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.deepPurple,
                  ),
                ),
                child: TextField(
                  controller: controller.field,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                iconSize: 35,
                onPressed: controller.submit,
                icon: const Icon(
                  Icons.send,
                  color: Color.fromARGB(255, 6, 124, 10),
                ),
              ),
            ],
          ),
        ),
      ),
      isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : const SizedBox.shrink(),
    ],
  );
}
