import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:managment/login/login.dart';
import 'package:managment/widgets/bottomnavigationbar.dart';
import 'php.dart';
import 'package:managment/Screens/home.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var balanceController = TextEditingController();

  var isobsecure =true;
  validateEmail() async {
    try{
      var response= await http.post(Uri.parse(Api.validateEmail),
          body:{
            'user_email' :emailController.text.trim(),

          }


      );
      if(response.statusCode == 200){
        var resBody=  jsonDecode(response.body);
        if(resBody['exist'] == true){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email already Exists',style: TextStyle(
                  color: Colors.white
              ),),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.blue,


            ),
          );
        }
        else{
          register();
        }
      }

    }catch(e){
      print(e);
    }
  }

  register()async{

    try{
      var res= await http.post(Uri.parse(Api.signup),
        body: {
          'user_name':userNameController.text.trim(),
          'user_email':emailController.text.trim(),
          'user_password':passwordController.text.trim(),
          'user_balance':balanceController.text,
        },
      );
      if (res.statusCode == 200) {
        var resbody = jsonDecode(res.body);
        if (resbody['success'] == true) {
          // Access the data using array notation
          String name = resbody['user_name'];
          String balance = resbody['user_balance'];
          int id =resbody['user_id'];

          if (resbody['success']) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Signup successfully'),
                duration: Duration(seconds: 3),
                backgroundColor: Colors.blue,
              ),
            );

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Bottom(name: name, balance: balance ,id:id),
            ));
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error occurred, try again'),
                duration: Duration(seconds: 3),
                backgroundColor: Colors.blue,

              ),
            );
          }
        }
      }
    }catch(e){
      print(e.toString());


    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
          builder: (contect, cons){
            return ConstrainedBox(constraints: BoxConstraints(
              minHeight:cons.maxHeight,
            ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height:285 ,
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
                        decoration:const BoxDecoration(
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
                          padding: const EdgeInsets.fromLTRB(30,30,30,8),
                          child: Column(

                            children: [
                              // email and password and login
                              Form(
                                  key: formKey,
                                  child:Column(
                                      children:[

                                        // name
                                        TextFormField(
                                          controller: userNameController,
                                          validator: (val)=>val=="" ? "Please write your name" : null,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.person,
                                              color: Colors.black,
                                            ),
                                            hintText: "User Name",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            enabledBorder:OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            contentPadding:const EdgeInsets.symmetric(horizontal: 14,vertical: 6),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                        ),
                                        const SizedBox(height: 18,),

                                        // email
                                        TextFormField(
                                          controller: emailController,
                                          validator: (val)=>val=="" ? "Please fill an email" : null,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.email,
                                              color: Colors.black,
                                            ),
                                            hintText: "email",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            enabledBorder:OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            contentPadding:const EdgeInsets.symmetric(horizontal: 14,vertical: 6),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                        ),
                                        const SizedBox(height: 18,),
                                        //   password

                                         TextFormField(
                                          controller: passwordController,

                                          validator: (val)=>val=="" ? "Please fill the password" : null,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.vpn_key_sharp,
                                              color: Colors.black,
                                            ),


                                            hintText: "password",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            enabledBorder:OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            contentPadding:const EdgeInsets.symmetric(horizontal: 14,vertical: 6),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                        ),
                                        const SizedBox(height: 18,),
                                        TextFormField(
                                          controller: balanceController,
                                          validator: (val)=>val=="" ? "Please enter your balance" : null,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.email,
                                              color: Colors.black,
                                            ),
                                            hintText: "Balance",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            enabledBorder:OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30),
                                                borderSide:const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            contentPadding:const EdgeInsets.symmetric(horizontal: 14,vertical: 6),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                        ),

                                        // button login
                                        const SizedBox(height: 18,),

                                        Material(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(30),
                                          child: InkWell(
                                            onTap: () async {
                                              if(formKey.currentState?.validate() ?? false){
                                                await validateEmail();
                                              }
                                            },
                                            borderRadius:BorderRadius.circular(30) ,
                                            child:const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 28,
                                              ),
                                              child: Text("SignUp",style: TextStyle(
                                                color: Colors.white,
                                                fontSize:16,
                                              ),) ,
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
                                  const Text("Already signedup ?",style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16

                                  ),),
                                  TextButton(onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                                  }, child:const  Text("Login",style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18


                                  ),))

                                ],
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
