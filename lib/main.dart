import 'package:ecom/components/catelog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/profile.dart';
import 'components/home.dart';
import 'components/profile.dart';
import 'components/cartPage.dart';
import 'components/catelog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assesment App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        colorScheme: const ColorScheme.light(),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetList = <Widget>[
     ImageSliderScreen(),
     CategoryPage()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
  
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
  
        title: Image.asset("assets/images/logo.png",
        height: 25,),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined,
                size: 28),
            onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=>  const CartPage())
              );
            },
            
          ),
          IconButton(
            icon: const Icon(Icons.store,
                size: 28),
            onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=>const  MyProfile())
              );
            },
            
          ),
        ],
      ),
    
      body: Center(child: _widgetList[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
     
        fixedColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Catalog',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
