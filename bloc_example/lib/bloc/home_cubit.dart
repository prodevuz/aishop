import 'package:bloc_example/imports.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInit());
  TextEditingController field = TextEditingController();
  String str = '';
  void submit() {
    str = field.text;
  }
}
