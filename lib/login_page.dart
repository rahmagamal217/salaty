import 'package:flutter/material.dart';
import 'package:salaty/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerCity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Salaty'),
          leading: Image.asset('assets/images/icon.png'),
        ),
        body: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("assets/images/login_page_background.jpg"),
                    fit: BoxFit.fill),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: size.width * 0.8,
                        child: TextFormField(
                          validator: (value) {
                            if (value != null) {
                              if (value.contains('@') && value.contains('.')) {
                                return null;
                              } else {
                                return 'your email must contains @ and .';
                              }
                            } else {
                              return 'Invalid password';
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            prefixIconColor: Colors.deepPurple,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: size.width * 0.8,
                        child: TextFormField(
                          validator: (value) {
                            if (value != null) {
                              if (value.length >= 6) {
                                return null;
                              } else {
                                return 'Weak password';
                              }
                            } else {
                              return 'Invalid password';
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            prefixIconColor: Colors.deepPurple,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: size.width * 0.8,
                        child: TextFormField(
                          controller: controllerCity,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'City',
                            prefixIcon: Icon(Icons.location_on),
                            prefixIconColor: Colors.deepPurple,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return HomePage(
                                  city: controllerCity.text,
                                );
                              }));
                            }
                          });
                        },
                        child: const Text('Submit'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: (() {}),
                        child: const Text('Forgot your password?'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
