import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teamup/resources/auth_methods.dart';
import 'package:teamup/utils/colors.dart';
import 'package:teamup/widgets/loading.dart';
import 'package:teamup/widgets/text_field_input.dart';

// RegisterScreen widget which is a StatefulWidget
class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  const RegisterScreen({super.key, required this.toggleView});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

// State class for LoginScreen
class _RegisterScreenState extends State<RegisterScreen> {
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
    return loading? Loading() : Scaffold(
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
                    // Connect text
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Connect',
                            style: TextStyle(color: brandGreen, fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: ', ',
                            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: 'play',
                            style: TextStyle(color: brandGreen, fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: ', and ',
                            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: 'enjoy',
                            style: TextStyle(color: brandGreen, fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: '\nsports together—',
                            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5), // Spacer
                    // Logo SVG image
                    SvgPicture.asset(
                      'assets/svg_outline.svg',
                      height: 170,
                      colorFilter: ColorFilter.mode(brandGreen, BlendMode.srcIn),
                    ),
                    // Welcome text
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Your journey starts ',
                            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: 'here',
                            style: TextStyle(color: brandGreen, fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: '!',
                            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 13), // Spacer
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
                    const SizedBox(height: 5), 
                    Text(error, style: TextStyle(color: Colors.redAccent),),
                    const SizedBox(height: 5), // Spacer
                    // Sign up button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            setState(() {loading = true;});
                            dynamic result = await _auth.signUpUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                            if (result == null) {
                              setState(() {loading = false;});
                              setState(() {error = "Please enter a valid email and password.";}); 
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
                                'Sign up',
                                style: TextStyle(
                                  color: brandGreen,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                ),
                              ),
                            ),
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
                            text: 'Sport matchmaking at its ',
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          ),
                          TextSpan(
                            text: 'BEST',
                            style: TextStyle(color: brandGreen, fontSize: 23, height: 1.6),
                          ),
                          TextSpan(
                            text: '!',
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10), // Spacer
                    // Login text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            'Already have an account? ',
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
                              'Sign in.',
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