import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teamup/resources/auth_methods.dart';
import 'package:teamup/utils/colors.dart';
import 'package:teamup/widgets/loading.dart';
import 'package:teamup/widgets/text_field_input.dart';

// LoginScreen widget which is a StatefulWidget
class LoginScreen extends StatefulWidget {
  final Function toggleView;
  const LoginScreen({super.key, required this.toggleView});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// State class for LoginScreen
class _LoginScreenState extends State<LoginScreen> {
  // Controllers for email and password text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthMethods _auth = AuthMethods();

  // States
  bool loading = false;
  String error = '';

  @override
  void dispose() {
    super.dispose();
    // Dispose controllers when the widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              // Background SVG image
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/svg_outline.svg',
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 29, 29, 29),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              // Main content container
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(flex: 2, child: Container()), // Spacer
                    // Logo SVG image
                    SvgPicture.asset(
                      'assets/svg_outline.svg',
                      height: 225,
                      colorFilter: ColorFilter.mode(brandGreen, BlendMode.srcIn),
                    ),
                    // Email text field
                    TextFieldInput(
                      textInputType: TextInputType.emailAddress,
                      textEditingController: _emailController,
                      labelText: 'Email',
                      hintText: 'Please enter your email',
                    ),
                    const SizedBox(height: 20), // Spacer
                    // Password text field
                    TextFieldInput(
                      textInputType: TextInputType.text,
                      textEditingController: _passwordController,
                      labelText: 'Password',
                      hintText: 'Please enter your password',
                      isPass: true,
                    ),
                    const SizedBox(height: 5), // Spacer
                    // Error text
                    Text(error, style: TextStyle(color: Colors.redAccent)),
                    // Forgot password text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            'Forgot your password? ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Reset here.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20), // Spacer
                    // Login and Google sign-in buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            // Call the signInWithEmailAndPassword method from AuthMethods
                            setState(() {loading = true;});
                            dynamic result = await _auth.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
                            if (result == null) {
                              setState(() {
                              setState(() {loading = false;});
                                error = 'The credentials entered are invalid.';
                              });
                            }
                          },
                          child: Container(
                              width: 140,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(9)),
                                  side: BorderSide(color: brandGreen, width: 1),
                                ),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: brandGreen,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // User? user = await _signInWithGoogle();
                            // if (user != null) {
                            //   print("Signed in as: ${user.displayName}");
                            // }
                          },
                          child: Text("Sign in with Google"),
                        ),
                      ],
                    ),
                    Flexible(flex: 2, child: Container()), // Spacer
                    // Catch up text
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Catch up with your',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          TextSpan(
                            text: ' friends',
                            style: TextStyle(color: brandGreen, fontSize: 20, height: 1.6),
                          ),
                          TextSpan(
                            text: ' outside!',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10), // Spacer
                    // Sign up text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            'Don\'t have an account? ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
                              padding: EdgeInsets.symmetric(horizontal: 0),
                            ),
                            onPressed: () {
                              setState(() {loading = true;});
                              widget.toggleView();
                            },
                            child: Text(
                              'Sign up.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Spacer
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}