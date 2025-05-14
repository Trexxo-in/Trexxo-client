import 'package:flutter/material.dart';

class ShowLogin extends StatefulWidget {
  const ShowLogin({super.key});

  @override
  State<ShowLogin> createState() => _ShowLoginState();
}

class _ShowLoginState extends State<ShowLogin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Your Journey, ",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Text(
                    "Your Rules",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              OutlinedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/google.png'),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Continue with Google",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
              OutlinedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.apple,
                          size: 32,
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Continue with Apple",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 42 / 100,
                    height: 2,
                    color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text("OR"),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 42 / 100,
                    height: 2,
                    color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 40,),
               ElevatedButton(
                      onPressed: () {
                       
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5557F6),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                        "Sign in with email",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.email)
                      ],),
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}
