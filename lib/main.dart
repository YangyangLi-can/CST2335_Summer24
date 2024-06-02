import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Recipes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Recipes App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Delicious Recipes", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Find your favorite recipes", style: TextStyle(fontSize: 20)),
            ),
            Text("By Meat", style: TextStyle(fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: _buildImageStack("images/beef.jpg", "Beef")),
                Expanded(child: _buildImageStack("images/chicken.jpg", "Chicken")),
                Expanded(child: _buildImageStack("images/pork.jpg", "Pork")),
                Expanded(child: _buildImageStack("images/seafood.jpg", "Seafood")),
              ],
            ),
            Text("By Course", style: TextStyle(fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: _buildImageStack("images/main_dishes.jpg", "Main Dishes", alignment: Alignment.bottomCenter)),
                Expanded(child: _buildImageStack("images/salad.jpg", "Salad Recipes", alignment: Alignment.bottomCenter)),
                Expanded(child: _buildImageStack("images/side_dishes.jpg", "Side Dishes", alignment: Alignment.bottomCenter)),
                Expanded(child: _buildImageStack("images/crockpot.jpg", "Crockpot", alignment: Alignment.bottomCenter)),
              ],
            ),
            Text("By Dessert", style: TextStyle(fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: _buildImageStack("images/cakes.jpg", "Cakes", alignment: Alignment.bottomCenter)),
                Expanded(child: _buildImageStack("images/pies.jpg", "Pies", alignment: Alignment.bottomCenter)),
                Expanded(child: _buildImageStack("images/cookies.jpg", "Cookies", alignment: Alignment.bottomCenter)),
                Expanded(child: _buildImageStack("images/ice_cream.jpg", "Ice Cream", alignment: Alignment.bottomCenter)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageStack(String imagePath, String text, {Alignment alignment = Alignment.center}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        alignment: alignment,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.black, blurRadius: 2)])),
        ],
      ),
    );
  }
}