import 'package:flutter/material.dart'; // For basic Flutter widgets and MaterialApp.
import 'package:flutter/cupertino.dart'; // For Cupertino widgets like CupertinoButton and CupertinoTextFormFieldRow.
import 'package:flutter/services.dart'; // For system services like TextInputAction, and possibly for text field focus handling if needed.
import 'package:capella/data/global_data.dart';
import 'package:capella/transitions/slide_from_left_transition.dart';
import 'package:capella/transitions/slide_from_right_transition.dart';
import 'listener_root_tabbed_page.dart';
import 'package:capella/pages/choice_page.dart';
import 'like_page.dart';

class ListenerLoginPage extends StatefulWidget {
  const ListenerLoginPage({super.key});

  @override
  State<ListenerLoginPage> createState() => _ListenerLoginPageState();
}

class _ListenerLoginPageState extends State<ListenerLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: darkGradient,
              tileMode: TileMode.mirror,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.arrow_back_ios),
                        style: const ButtonStyle(
                            iconColor: MaterialStatePropertyAll<Color>(purp)),
                        label: const Text('Listener',
                            style: TextStyle(fontSize: 20, color: purp)),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            SlideFromLeftPageRoute(page: const ChoicePage()),
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: Image.asset('assets/images/CapellaLogo1.png',
                        fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 100),
                  CupertinoTextFormFieldRow(
                    padding: const EdgeInsets.all(15),
                    controller: emailController,
                    placeholder: "Email",
                    textInputAction: TextInputAction.next,
                    placeholderStyle: const TextStyle(
                        color: Color.fromARGB(255, 96, 85, 126)),
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    style: const TextStyle(color: buttonText),
                  ),
                  const SizedBox(height: 25),
                  const SizedBox(height: 10),
                  CupertinoTextFormFieldRow(
                    padding: const EdgeInsets.all(15),
                    controller: passwordController,
                    placeholder: "Password",
                    placeholderStyle: const TextStyle(
                        color: Color.fromARGB(255, 96, 85, 126)),
                    obscureText: true,
                    style: const TextStyle(color: buttonText),
                    autofillHints: const [AutofillHints.password],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        color: purp,
                        padding: EdgeInsets.only(
                            top: 3,
                            bottom: 3,
                            left: (screenWidth / 2 - 50),
                            right: (screenWidth / 2 - 50)),
                        onPressed: () {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please fill in all fields')),
                            );
                          } else {
                            if ((emailController.text ==
                                        "chintanvajariya@gmail.com" &&
                                    passwordController.text == "password") ||
                                (emailController.text == "a" &&
                                    passwordController.text == "a")) {
                              status = 'listener';
                              signedIn = true;
                              Navigator.pushReplacement(
                                context,
                                SlideFromRightPageRoute(
                                    page: const ListenerRootTabbedPage()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Invalid Credentials')),
                              );
                            }
                          }
                        },
                        child: const Text('Log In',
                            style: TextStyle(
                                color: buttonText,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: screenWidth / 2 - 60,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 71, 71, 71)),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('OR',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 164, 164, 164),
                                letterSpacing: 0.2)),
                      ),
                      Container(
                        height: 1,
                        width: screenWidth / 2 - 60,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 71, 71, 71)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, letterSpacing: 0.2)),
                      CupertinoButton(
                        color: Colors.transparent,
                        padding:
                            const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                        onPressed: () {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please fill in all fields')),
                            );
                          } else {
                            status = 'listener';
                            signedIn = true;
                            Navigator.pushReplacement(
                              context,
                              SlideFromRightPageRoute(page: const LikePage()),
                            );
                          }
                        },
                        child: const Text('Sign Up',
                            style: TextStyle(
                                color: buttonText,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}