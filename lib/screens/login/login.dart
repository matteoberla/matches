import 'package:flutter/material.dart';
import 'package:matches/components/login_components/login_button.dart';
import 'package:matches/components/login_components/login_info_textfield.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/palladio_std_components/palladio_loading.dart';
import 'package:matches/controllers/login_handlers/login_callback.dart';
import 'package:matches/controllers/login_handlers/login_handler.dart';
import 'package:matches/state_management/login_provider/login_provider.dart';
import 'package:matches/styles.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  LoginCallback loginCallback = LoginCallback();
  LoginHandler loginHandler = LoginHandler();

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<bool>? pageInitialized;

  @override
  void initState() {
    super.initState();
    pageInitialized = loginHandler.initLoginPage(context);
  }

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: true);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: FutureBuilder(
            future: pageInitialized,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return PalladioBody(
                  showBottomBar: false,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),

                          // logo
                          const Icon(
                            Icons.lock,
                            size: 100,
                          ),

                          const SizedBox(height: 50),

                          // welcome back, you've been missed!
                          const Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 25),

                          // username textfield
                          LoginInfoTextfield(
                            controller: usernameController,
                            hintText: 'E-mail / Tel. ',
                            obscureText: false,
                          ),

                          const SizedBox(height: 10),

                          // password textfield
                          LoginInfoTextfield(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: true,
                          ),

                          const SizedBox(height: 10),

                          const SizedBox(height: 25),

                          // sign in button
                          LoginButton(
                            title: "Accedi",
                            onTap: () async {
                              await loginCallback.loginPressed(
                                  context,
                                  loginProvider,
                                  usernameController.text,
                                  passwordController.text);
                            },
                          ),

                          const SizedBox(height: 40),

                          // not a member? register now
                          GestureDetector(
                            onTap: () {
                              loginCallback.onSignupPressed(context);
                            },
                            child: Container(
                              color: transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Prima volta qui?',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'Registrati ora',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const PalladioLoading(
                  absorbing: true,
                );
              }
            }),
      ),
    );
  }
}
