import 'package:flutter/material.dart';
import 'package:matches/components/login_components/login_button.dart';
import 'package:matches/components/login_components/login_info_textfield.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/controllers/signup_handlers/signup_callback.dart';
import 'package:matches/styles.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //
  SignupCallback signupCallback = SignupCallback();

  // text editing controllers
  final nicknameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  //
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: PalladioBody(
          showBottomBar: false,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // logo
                  const Icon(
                    Icons.lock_open,
                    size: 100,
                  ),

                  const SizedBox(height: 50),

                  // welcome back, you've been missed!
                  const Text(
                    'Registrazione',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 25),

                  LoginInfoTextfield(
                    controller: nicknameController,
                    hintText: 'Nickname',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // username textfield
                  LoginInfoTextfield(
                    controller: usernameController,
                    hintText: 'Tel.',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  LoginInfoTextfield(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: !showPassword,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        setState(
                          () {
                            showPassword = !showPassword;
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 25),

                  // sign in button
                  LoginButton(
                    title: "Registrati",
                    onTap: () async {
                      await signupCallback.onSignupPressed(
                          context,
                          usernameController.text,
                          passwordController.text,
                          nicknameController.text);
                    },
                  ),

                  const SizedBox(height: 40),

                  GestureDetector(
                    onTap: () {
                      signupCallback.onLoginPressed(context);
                    },
                    child: Container(
                      color: transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Già iscritto?',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'Accedi ora',
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
                  // not a member? register now
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
