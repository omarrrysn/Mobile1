import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:managment/login/signup.dart';
import 'package:managment/widgets/bottomnavigationbar.dart';
import 'php.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Login() async {
    try {
      var res = await http.post(Uri.parse(Api.login),
          body: {
            "user_email": emailController.text.trim(),
            "user_password": passwordController.text.trim(),
          });
      if (res.statusCode == 200) {
        var resbody = jsonDecode(res.body);
        if (resbody['success'] == true) {
          // Access the data using array notation
          String name = resbody['user_name'] ?? '';
          String balance = resbody['user_balance'].toString() ?? '';
          int id = resbody['user_id'] ?? '';

          if (resbody['success']) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login successfuly'),
                duration: Duration(seconds: 3),
                backgroundColor: Colors.blue,
              ),
            );

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  Bottom(name: name, balance: balance, id: id),
            ));
          } else {
            // Server returned an error response
            print('Failed to connect to the server');
          }
        }
      }
    }


    catch(e){
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login fail ", style: TextStyle(
              color: Colors.white
          ),),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.blue,


        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
          builder: (contect, cons) {
            return ConstrainedBox(constraints: BoxConstraints(
              minHeight: cons.maxHeight,
            ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 285,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0), // Set your desired border radius
                        child: Image.asset(
                          "../images/balance1.png",
                          fit: BoxFit.cover, // You may want to adjust the fit based on your requirements
                        ),
                      ),
                    ),
                    //   login signup

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.all(
                                Radius.circular(60)
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  color: Colors.black26,
                                  offset: Offset(0, -3)
                              )
                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                          child: Column(

                            children: [
                              // email and password and login
                              Form(
                                  key: formKey,
                                  child: Column(
                                      children: [
                                        // email
                                        TextFormField(
                                          controller: emailController,
                                          validator: (val) =>
                                          val == ""
                                              ? "Please fill an email"
                                              : null,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.email,
                                              color: Colors.black,
                                            ),
                                            hintText: "email",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(30),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(30),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(30),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(30),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            contentPadding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 14, vertical: 6),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                        ),
                                        const SizedBox(height: 18,),
                                        //   password


                                            TextFormField(
                                              controller: passwordController,
                                              validator: (val) =>
                                              val == ""
                                                  ? "Please fill the password"
                                                  : null,
                                              decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.vpn_key_sharp,
                                                  color: Colors.black,
                                                ),

                                                hintText: "password",
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(30),
                                                    borderSide: const BorderSide(
                                                      color: Colors.white60,
                                                    )
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(30),
                                                    borderSide: const BorderSide(
                                                      color: Colors.white60,
                                                    )
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(30),
                                                    borderSide: const BorderSide(
                                                      color: Colors.white60,
                                                    )
                                                ),
                                                disabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(30),
                                                    borderSide: const BorderSide(
                                                      color: Colors.white60,
                                                    )
                                                ),
                                                contentPadding: const EdgeInsets
                                                    .symmetric(horizontal: 14,
                                                    vertical: 6),
                                                fillColor: Colors.white,
                                                filled: true,
                                              ),
                                            ),
                                        const SizedBox(height: 18,),

                                        // button login
                                        Material(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(
                                              30),
                                          child: InkWell(
                                            onTap: () async {
                                              if(formKey.currentState?.validate() ?? false){
                                                await Login();
                                              }
                                            },
                                            borderRadius: BorderRadius
                                                .circular(30),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 28,
                                              ),
                                              child: Text(
                                                "Login", style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),),
                                            ),
                                          ),
                                        )


                                      ]
                                  )

                              ),
                              SizedBox(height: 16,),

                              // text button
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Don't have an account ?",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16

                                      ),),
                                    TextButton(onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupScreen()));
                                    },
                                        child: const Text(
                                          "Signup", style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18


                                        ),))
                                  ]
                              ),


                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}


