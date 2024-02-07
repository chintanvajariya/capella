import 'package:capella/pages/artist_pages/artist_root_tabbed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:capella/data/global_data.dart';
import 'package:capella/transitions/slide_from_left_transition.dart';
import 'package:capella/transitions/slide_from_right_transition.dart';
import 'package:capella/pages/choice_page.dart'; 

class ArtistLoginPage extends StatefulWidget {
  const ArtistLoginPage({super.key});

  @override
  State<ArtistLoginPage> createState() => _ArtistLoginPageState();
}

class _ArtistLoginPageState extends State<ArtistLoginPage> {
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
              colors: lightGradient,
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
                        label: const Text('Artist',
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
                    child: Image.asset('assets/images/CapellaLogo2.png',
                      fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 100),
                  CupertinoTextFormFieldRow(
                    padding: const EdgeInsets.all(15),
                    controller: emailController,
                    placeholder: "Email",
                    textInputAction: TextInputAction.next,
                    placeholderStyle: const TextStyle(
                      color: Color.fromARGB(255, 96, 85, 126)
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: buttonText),
                    autofillHints: const [AutofillHints.email],
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
                              status = 'artist';
                              signedIn = true;
                              Navigator.pushReplacement(
                                context,
                                SlideFromRightPageRoute(
                                    page: const ArtistRootTabbedPage()),
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
                            status = 'artist';
                            signedIn = true;
                            Navigator.pushReplacement(
                              context,
                              SlideFromRightPageRoute(
                                  page: const ArtistRootTabbedPage()),
                            );
                          }
                        },
                        child: const Text('Sign Up',
                          style: TextStyle(
                            color: buttonText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          )
                        ),
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