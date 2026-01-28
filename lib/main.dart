import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My CV',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Resumé',
        titleStyle: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

// Fixed variable declaration
final Widget personalImage = Image.asset(
  'assets/Personal.jpg',
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) => Container(
    color: Colors.grey[300],
    child: const Icon(Icons.person, size: 50),
  ),
);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, this.titleStyle});
  final String title;
  final TextStyle? titleStyle;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: widget.titleStyle),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLogo('assets/itc_logo.png'),
                _buildLogo('assets/gtr_logo.png'),
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              "ជាតិ សាសនា ព្រះមហាក្សត្រ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 20),
            
            // Fixed Profile Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 120,
                    height: 150,
                    child: personalImage, // Using the variable
                  ),
                ),
                const SizedBox(width: 20),
                const Expanded( // Added Expanded to prevent text overflow
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: Kao Kimhak", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Major: Telecommunication and Networking Engineering"),
                      Text("Email: kaokimhak2019@email.com"),
                      Text("Contact: 093391505"), // Fixed "Content" to "Contact"
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("About me",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("I'am year4 student at the Institute of Technology of Cambodia, pursuing a degree in Telecommunication and Networking Engineering.\n- I have a strong passion for technology and innovation, and I am eager to contribute my skills and knowledge to the field."),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(String path) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Image.asset(
        path,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 40),
      ),
    );
  }
}