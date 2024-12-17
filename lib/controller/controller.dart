
import 'package:fibonacci_test/models/model.dart';
import 'package:get/get.dart';



class FibonacciController extends GetxController {
  int indexSelected = -1;
  List<FibonanciModel> totalFibo = [];
  List<FibonanciModel> squareFibo = [];  List<FibonanciModel> crossFibo = [];  List<FibonanciModel> cycleFibo = [];

  @override
  void onInit() {
    // TODO: implement onInit
    // generateFibonacciNumbers(41);
    super.onInit();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  int fibonacci(int n) {
    if (n <= 1) {
      return n;
    } else {
      return fibonacci(n - 1) + fibonacci(n - 2);
    }
  }
  generateFibonacciNumbers(int count) {
    int number = 0;

    for (int i = 0; i < count; i++) {

      if (i <= 1) {
        number = i;

      } else {
        number = totalFibo[i - 1].number + totalFibo[i - 2].number;
      }

      totalFibo.add(FibonanciModel(id: i, number: number, type: getFiboType(i)));
    }
  }


  addItems(int index, FibonanciModel model) {
    switch (model.type) {
      case Type.square:
        squareFibo.add(model);
        break;
      case Type.cross:
        crossFibo.add(model);
        break;
      case Type.circle:
        cycleFibo.add(model);
        break;
    }
    totalFibo.removeAt(index);
    indexSelected = model.id;
    update();
  }

  removeItems(int index, FibonanciModel model) {
    switch (model.type) {
      case Type.square:
        squareFibo.removeAt(index);
        break;
      case Type.cross:
        crossFibo.removeAt(index);
        break;
      case Type.circle:
        cycleFibo.removeAt(index);
        break;
    }
    indexSelected = model.id;
    totalFibo.add(model);
    totalFibo.sort((a, b) => a.id.compareTo(b.id));
    update();
  }

  List<FibonanciModel> getModelType(Type type) {
    List<FibonanciModel> list = [];
    switch (type) {
      case Type.square:
        list = squareFibo;

      case Type.cross:
        list = crossFibo;

      case Type.circle:
        list = cycleFibo;
    }

    list.sort((a, b) => a.id.compareTo(b.id));
    return list;
  }

  Type getFiboType(int count) {
    int j =  fibonacci(count) % 3;

    switch (j) {
      case 0:
        return Type.circle;
      case 1:
        return Type.square;
      default:
        return Type.cross;
    }
  }
}
