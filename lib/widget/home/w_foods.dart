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
              picture(),
            ],
          ),
        ),
      ],
    );
  }
  Widget picture(){
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: ListView.builder(
        itemBuilder: (context, index) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Image.asset(
                pic[index],
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  pic.removeAt(index);
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(Icons.close, size: 16),
                ),
              ),
            ),
          ],
        ),
        itemCount: pic.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
  List<String> foods = [
    
  ]

}
