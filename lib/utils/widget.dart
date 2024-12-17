import 'package:fibonacci_test/controller/controller.dart';
import 'package:fibonacci_test/models/model.dart';
import 'package:flutter/material.dart';

Widget buildForm({

  required BuildContext context,
  required int index,
  required ScrollController scrollController,
  required FibonacciController ctrl,
  required FibonanciModel model,

}) {
  return SizedBox(
    height: 70,
    child: ListTile(
      onTap: () {
        ctrl.addItems(index, model);
        List<FibonanciModel> fiboNumbers = ctrl.getModelType(model.type);
        showModalBottomSheet(
            context: (context),
            isScrollControlled: true,
            builder: (_) {
              return DraggableScrollableSheet(
                expand: false,
                builder: (context, scrollControllerModal) {

                  int index = fiboNumbers.indexOf(model);

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (scrollControllerModal.hasClients) {
                      scrollControllerModal.animateTo(index * 70, duration: const Duration(seconds: 1), curve: Curves.ease);
                    }
                  });

                  return ListView.builder(
                      controller: scrollControllerModal,
                      itemCount: fiboNumbers.length,
                      shrinkWrap: true,

                      itemBuilder: (context, index) {
                        return BuildBottomSheet(
                            index: index,
                            context: context,
                            fiboMd: fiboNumbers[index],
                            controlle: ctrl,
                            scrollController: scrollController);
                      });
                },
              );
            });
      },
      title: Text('index: ${model.id},Number: ${model.number}'),
      trailing: Icon(icon(model.type)),
      tileColor: ctrl.indexSelected == model.id   ? Colors.red     : Colors.white,
    ),
  );
}


Widget BuildBottomSheet(
    {
      required int index,
      required BuildContext context,
      required FibonanciModel fiboMd,
      required FibonacciController controlle,
      required ScrollController scrollController
    }) {
  return SizedBox(
    height: 70,
    child: ListTile(
      onTap: () {
        controlle.removeItems(index, fiboMd);
        Navigator.pop(context);

        int i = controlle.totalFibo.indexOf(fiboMd);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.animateTo(i * 70, duration: const Duration(seconds: 1), curve: Curves.ease);
          }
        });

      },
      title: Text('Number: ${fiboMd.number}'),
      subtitle: Text('index: ${fiboMd.id}'),
      trailing: Icon(icon(fiboMd.type)),
      tileColor: controlle.indexSelected == fiboMd.id
          ? Colors.green
          : Colors.white,
    ),
  );
}

IconData icon(Type type) {
  switch (type) {
    case Type.square:
      return Icons.square_outlined;
    case Type.cross:
      return Icons.close;
    case Type.circle:
      return Icons.circle;
  }
}

