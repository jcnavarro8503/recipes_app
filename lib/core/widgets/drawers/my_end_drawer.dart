import 'package:flutter/material.dart';

class MyEndDrawer extends StatefulWidget {
  const MyEndDrawer({Key? key}) : super(key: key);
  @override
  MyEndDrawerState createState() => MyEndDrawerState();
}

class MyEndDrawerState extends State<MyEndDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          toolbarHeight: size.height * .1,
          leading: IconButton(
              icon: const Icon(
                Icons.bed,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Image.asset(
              'assets/images/app_bar_logo.png',
              width: size.width * .4,
              fit: BoxFit.contain,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.cancel,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            children: [
              // Pagar
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: .5),
                      right: BorderSide(width: .5),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   'assets/images/menu_00_pay.png',
                      //   width: size.width * .15,
                      //   fit: BoxFit.fitWidth,
                      // ),
                      SizedBox(height: 20),
                      Text(
                          // AppLocalizations.of(context)!.pay,
                          'manu 1')
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
