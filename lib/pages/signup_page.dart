import 'dart:ui';

import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), // Path to your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 350,
              height: 630,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: Container(
                    color: Colors.white.withOpacity(0.1),
                    padding: const EdgeInsets.all(
                        20), // Add padding inside the container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'RateMate',
                          style: TextStyle(
                            fontSize: 40,
                            color: Color(0xFFACACAC),
                          ),
                        ),
                        SizedBox(
                            height:
                                20), // Space between the title and the text field
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            hintStyle: TextStyle(color: Color(0xFFACACAC)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: TextStyle(color: Color(0xFFACACAC)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Username',
                            hintStyle: TextStyle(color: Color(0xFFACACAC)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Country',
                            hintStyle: TextStyle(color: Color(0xFFACACAC)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Color(0xFFACACAC)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(color: Color(0xFFACACAC)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: 350,
                          child: TextButton(
                            onPressed: () {
                              // Add your button's onPressed functionality here
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF13294C),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
