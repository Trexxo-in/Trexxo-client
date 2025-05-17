import 'package:flutter/material.dart';
import 'package:trexxo_cab_client/Screens/create_account.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

bool islogin = false;

class _SignupState extends State<Signup> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? emailValidator(String? value) {
    if (value == null ||
        !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
            .hasMatch(value)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  void submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          elevation: 6,
          content: Builder(
            builder: (content) => Material(
              type: MaterialType.transparency,
              child: Text(
                'Login Successful!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CreateAccount()));
    }
  }

  bool isPassword = true;
  String? passValidator(String? value) {
    if (value == null ||
        !RegExp(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$")
            .hasMatch(value)) {
      return 'Password must have:\n'
          '- At least 6 characters\n'
          '- An uppercase letter\n'
          '- A lowercase letter\n'
          '- A digit\n'
          '- A special character';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor:
                            MediaQuery.of(context).platformBrightness ==
                                    Brightness.light
                                ? const Color.fromARGB(255, 236, 231, 231)
                                : const Color.fromARGB(255, 139, 139, 139),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.light
                                ? Colors.black
                                : Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login to your account',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          autocorrect: true,
                          validator: emailValidator,
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter your Email Address',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.light
                                        ? Colors.black38
                                        : Colors.white38),
                            labelText: 'Email',
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            prefixIcon: Icon(Icons.email,
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? Colors.black38
                                        : Colors.white38),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MediaQuery.of(context)
                                              .platformBrightness ==
                                          Brightness.light
                                      ? Colors.black38
                                      : Colors.white38,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MediaQuery.of(context)
                                              .platformBrightness ==
                                          Brightness.light
                                      ? Colors.black54
                                      : Colors.white54,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MediaQuery.of(context)
                                              .platformBrightness ==
                                          Brightness.light
                                      ? Colors.black38
                                      : Colors.white38,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          autocorrect: true,
                          validator: passValidator,
                          controller: _passController,
                          obscureText: isPassword,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  isPassword = !isPassword;
                                  setState(() {});
                                },
                                icon: isPassword
                                    ? Icon(Icons.visibility_off_outlined)
                                    : Icon(Icons.remove_red_eye_outlined)),
                            hintText: 'Enter your Password',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.light
                                        ? Colors.black38
                                        : Colors.white38),
                            labelText: 'Password',
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            prefixIcon: Icon(Icons.lock,
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? Colors.black38
                                        : Colors.white38),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MediaQuery.of(context)
                                              .platformBrightness ==
                                          Brightness.light
                                      ? Colors.black38
                                      : Colors.white38,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MediaQuery.of(context)
                                              .platformBrightness ==
                                          Brightness.light
                                      ? Colors.black54
                                      : Colors.white54,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MediaQuery.of(context)
                                              .platformBrightness ==
                                          Brightness.light
                                      ? Colors.black38
                                      : Colors.white38,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: submitForm,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Login'),
                                SizedBox(width: 10),
                                Icon(Icons.login),
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF5555FF),
                              foregroundColor: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text('Forgot Password ? ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 14)),
                            InkWell(
                              child: Text(
                                'Reset Password',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Color(0xFF5555FF), fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 41 / 100,
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
                      width: MediaQuery.of(context).size.width * 41 / 100,
                      height: 2,
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ],
                ),
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
                  height: 20,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
