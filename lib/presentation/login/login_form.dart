/**
 * UI del formulario para iniciar sesion en swad
 */
import 'package:flutter/material.dart';
import 'package:untitled/utilities/constants.dart';

class LoginForm extends StatefulWidget {



  final TextEditingController userController , passwordController;

  final void Function()? loginFunction;


  @override
  State<LoginForm> createState() => _LoginFormState();

  LoginForm({required this.userController, required this.passwordController , required this.loginFunction});
}

class _LoginFormState extends State<LoginForm> {


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 60),
          child: const Text(
            "Swad .",
            style: TextStyle(
              fontSize: 35,
              color: Color(0xffe6e1e4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: Stack(
            children: [
              Container(
                height: 150,
                margin: const EdgeInsets.only(
                  right: 70,
                ),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 32),
                      child: TextField(
                        controller: widget.userController,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 20),
                          border: InputBorder.none,
                          icon: Icon(Icons.account_circle_rounded),
                          hintText: "Username",
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 32),
                      child: TextField(
                        controller: widget.passwordController,
                        cursorColor: kBackgroundColor,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 22),
                          border: InputBorder.none,
                          icon: Icon(Icons.lock),
                          hintText: "********",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: widget.loginFunction,
                  child: Container(
                    margin: const EdgeInsets.only(right: 15),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow[100]!.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      shape: BoxShape.circle,
                      color: Color(0xff645c64)
                    ),
                    child: const Icon(
                      Icons.arrow_forward_outlined,
                      color: Color(0xffe6e1e4),
                      size: 32,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16, top: 16),
              child: Text(
                "Forgot ?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, top: 24),
              child: const Text(
                "Register",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffe98f60),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}