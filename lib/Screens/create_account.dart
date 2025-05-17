import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trexxo_cab_client/Screens/otp.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String? _selectedCountryCode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void validateItems() {
    if (_formKey.currentState!.validate()) {
      // Perform the action you want to do after validation
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Otp()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Set up your profile',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 12,
        backgroundColor: Color(0xFF5555FF),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person_2_outlined,
                      size: 100,
                    )),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autocorrect: true,
                        validator: (value) => value == null || value.length < 3
                            ? 'Enter a valid name'
                            : null,
                        keyboardType: TextInputType.name,
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter your Name',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: MediaQuery.of(context)
                                              .platformBrightness ==
                                          Brightness.light
                                      ? Colors.black38
                                      : Colors.white38),
                          labelText: 'Full Name',
                          labelStyle: Theme.of(context).textTheme.bodyMedium,
                          prefixIcon: Icon(Icons.person,
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.light
                                      ? Colors.black38
                                      : Colors.white38),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? Colors.black38
                                        : Colors.white38,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? Colors.black54
                                        : Colors.white54,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? Colors.black38
                                        : Colors.white38,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              _dobController.text =
                                  "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                            });
                          }
                        },
                        child: AbsorbPointer(
                          // Prevents keyboard from showing up
                          child: TextFormField(
                            keyboardType: TextInputType.datetime,
                            controller: _dobController,
                            decoration: InputDecoration(
                              hintText: '10/10/2010',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: MediaQuery.of(context)
                                                  .platformBrightness ==
                                              Brightness.light
                                          ? Colors.black38
                                          : Colors.white38),
                              labelText: 'Date of Birth',
                              labelStyle:
                                  Theme.of(context).textTheme.bodyMedium,
                              prefixIcon: Icon(Icons.date_range,
                                  color: MediaQuery.of(context)
                                              .platformBrightness ==
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
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Code',
                                labelStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                prefixIcon: Icon(Icons.flag,
                                    color: MediaQuery.of(context)
                                                .platformBrightness ==
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.light
                                        ? Colors.black54
                                        : Colors.white54,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              value: '+91', // Default value
                              items: [
                                DropdownMenuItem(
                                    value: '+1', child: Text('+1')),
                                DropdownMenuItem(
                                    value: '+91', child: Text('+91')),
                                DropdownMenuItem(
                                    value: '+44', child: Text('+44')),
                                DropdownMenuItem(
                                    value: '+61', child: Text('+61')),
                                DropdownMenuItem(
                                    value: '+81', child: Text('+81')),
                              ],
                              onChanged: (value) {
                                // Handle country code change
                                setState(() {
                                  _selectedCountryCode = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              autocorrect: true,
                              controller: _phoneController,
                              validator: (value) =>
                                  value == null || value.length < 10
                                      ? 'Enter a valid phone number'
                                      : null,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Enter your Phone Number',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.light
                                            ? Colors.black38
                                            : Colors.white38),
                                labelText: 'Phone Number',
                                labelStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                prefixIcon: Icon(Icons.phone,
                                    color: MediaQuery.of(context)
                                                .platformBrightness ==
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MediaQuery.of(context)
                                                .platformBrightness ==
                                            Brightness.light
                                        ? Colors.black54
                                        : Colors.white54,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: validateItems,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5557F6),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 50)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Continue",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
