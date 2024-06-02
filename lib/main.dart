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
        backgroundColor: Colors.white,
        title: Text(widget.title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("BROWSE CATEGORIES", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text("Not sure about exactly which recipe you're looking for? Do a search, or\ndive into our most popular categories.", style: TextStyle(fontSize: 16)),
              SizedBox(height: 40),
              Text("BY MEAT", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              _buildImageRow(["beef.jpg", "chicken.jpg", "pork.jpg", "seafood.jpg"], ["BEEF", "CHICKEN", "PORK", "SEAFOOD"]),
              SizedBox(height: 40),
              Text("BY COURSE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              _buildImageRow(["main_dishes.jpg", "salad.jpg", "side_dishes.jpg", "crockpot.jpg"], ["Main Dishes", "Salad Recipes", "Side Dishes", "Crockpot"], bottomText: true),
              SizedBox(height: 40),
              Text("BY DESSERT", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              _buildImageRow(["ice_cream.jpg", "brownies.jpg", "pies.jpg", "cookies.jpg"], ["Ice Cream", "Brownies", "Pies", "Cookies"], bottomText: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageRow(List<String> images, List<String> texts, {bool bottomText = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (int i = 0; i < images.length; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipOval(
                child: Stack(
                  alignment: bottomText ? Alignment.bottomCenter : Alignment.center,
                  children: [
                    Image.asset("images/${images[i]}", fit: BoxFit.cover),
                    Container(
                      width: double.infinity,
                      color: bottomText ? Colors.black.withOpacity(0.5) : null,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        texts[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: bottomText ? 14 : 16,
                          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}