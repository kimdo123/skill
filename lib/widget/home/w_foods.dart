import 'dart:math';

import 'package:myhealthdata/util/common.dart';

class Foods extends StatefulWidget {
  const Foods({super.key});

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text('Foods', style: TextStyle(fontSize: 30)),
        ),
        // food 안에 내용
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          width: 370,
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 로고
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                // color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: SvgPicture.asset('assets/food.svg'),
                ),
              ),
              // 사진들
              Container(
                width: 200,
                height: 70,
                color: Colors.black,
                child: picture(a),
              )
            ],
          ),
        ),
      ],
    );
  }

  final int a = Random().nextInt(8);

  Widget picture(int a){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              foods[5], // 0 ~ 7
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
  List<String> foods = [
    'assets/foods/breakfast.jpg',
    'assets/foods/burger.jpg',
    'assets/foods/chocolate.jpg',
    'assets/foods/food.jpg',
    'assets/foods/pizza.jpg',
    'assets/foods/ramen.jpg',
    'assets/foods/sandwich.jpg',
    'assets/foods/watermelon.jpg',
  ];

}
