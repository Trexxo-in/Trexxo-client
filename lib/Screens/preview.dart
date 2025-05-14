import 'package:flutter/material.dart';
import 'package:trexxo_cab_client/Screens/show_login.dart';

class Preview_App extends StatefulWidget {
  const Preview_App({super.key});

  @override
  State<Preview_App> createState() => _Preview_AppState();
}

class _Preview_AppState extends State<Preview_App> {
  final PageController _controller = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() => currentIndex = index);
                  },
                  children: const [
                    Book_ride(),
                    Track_Ride(),
                    Safe_Ride(),
                  ]),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      bool isActive = index == currentIndex;
                      // Brightness brightness=MediaQuery.of(context).platformBrightness;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 30 : 20,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isActive
                              ? MediaQuery.of(context).platformBrightness ==
                                      Brightness.light
                                  ? const Color.fromARGB(255, 95, 8, 224)
                                  : const Color(0xFFAE86EC) // purple
                              : Colors.grey, // gray
                          borderRadius: BorderRadius.circular(16),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                if (currentIndex != 2)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _controller.animateToPage(++currentIndex,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5557F6),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowLogin()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5557F6),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50)),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Book_ride extends StatelessWidget {
  const Book_ride({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: const Color(0xFF5555FF),
                radius: 100,
                child: Container(
                  padding: const EdgeInsets.all(33),
                  height: 165,
                  width: 165,
                  child: Image.asset(
                    "assets/images/car.png",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
                child: Text(
              "Book a Ride",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Choose your pickup, set your stops, and book a ride in seconds — simple, fast, and flexible.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Track_Ride extends StatelessWidget {
  const Track_Ride({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: const Color(0xFF5555FF),
                radius: 100,
                child: Container(
                  padding: const EdgeInsets.all(33),
                  height: 165,
                  width: 165,
                  child: Image.asset(
                    "assets/images/track.png",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
                child: Text(
              "Track your ride",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Stay updated with real-time tracking, live driver location, and accurate arrival times for a worry-free experience.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Safe_Ride extends StatelessWidget {
  const Safe_Ride({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: const Color(0xFF5555FF),
                radius: 100,
                child: Container(
                  padding: const EdgeInsets.all(33),
                  height: 165,
                  width: 165,
                  child: Image.asset(
                    "assets/images/safe.png",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
                child: Text(
              "Safe & comfortable",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Every journey is backed by trusted drivers, well-maintained vehicles, and a commitment to your safety and comfort.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
