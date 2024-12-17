import 'package:fibonacci_test/controller/controller.dart';
import 'package:fibonacci_test/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  late final ScrollController scrollController;
  final fibo_ctl = Get.put(FibonacciController());

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    fibo_ctl.generateFibonacciNumbers(41);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Fibonacci List'),
              centerTitle: true,
            ),
            body: GetBuilder<FibonacciController>(
                init: FibonacciController(),
                builder: (_) => ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                itemCount: fibo_ctl.totalFibo.length,
                itemBuilder: (context, index) {
                  return buildForm(
                      context: context,
                      index: index,
                      scrollController: scrollController,
                      ctrl: fibo_ctl,
                      model: fibo_ctl.totalFibo[index],
                  );
                })
            )

        ));
  }
}
