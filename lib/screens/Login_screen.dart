import 'package:bloc_poc/cubit/auth_cubit.dart';
import 'package:bloc_poc/cubit/auth_state.dart';
import 'package:bloc_poc/screens/Register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'VerifyPhoneNumberScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _phoneNumber= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('LOGIN'),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: TextFormField(
              //     keyboardType: TextInputType.emailAddress,
              //     decoration: InputDecoration(
              //         hintText: 'Enter your email address here',
              //         labelText: "Email address",
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         )),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneNumber,
                  // obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Enter your phone number here',
                      labelText: "Phone Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if(state is AuthCodeSentState) {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => VerifyPhoneNumberScreen()
                    ));
                  }
                },
                builder: (context, state) {

                  if(state is AuthLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return _buildButton();

                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Need an Account? ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: 'Register',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //TODO navigate to the the register screen
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                          }),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return GestureDetector(
      onTap: () {
        //TODO:: login here
        String phoneNumber = "+91"+_phoneNumber.text;
        BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 35,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
