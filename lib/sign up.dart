import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/login.dart';

import 'homepage.dart';
class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}
class _registerState extends State<register> {
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  final formKey=GlobalKey <FormState>();
  final nameController= TextEditingController();
  final emailController=TextEditingController();
  final passswordController=TextEditingController();
  final genderController=TextEditingController();
  final surnameController=TextEditingController();

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('register'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
             const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderSide:const BorderSide(
                      color: Colors.cyan,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "username ",
                  hintText: "enter your username",
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'please enter your name';
                  }
                  else if (value.characters.contains("@")) {
                  }
                  return "invalid username";
                }
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mark_email_unread_sharp),
                  border: OutlineInputBorder(
                    borderSide:const BorderSide(
                      color: Colors.cyan,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "email",
                  hintText: "enter your email",
                ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'please enter your email';
                    }
                    else{
                      return null;
                    }
                  }
              ),
                 SizedBox(height: 30,),

             const SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                controller: passswordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderSide:const BorderSide(
                      color: Colors.cyan,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "password",
                  hintText: "enter your password",
                ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'please enter your password';
                    }
                    else{
                      return null;
                    }
                  }
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: genderController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_add_alt_1_rounded),
                  border: OutlineInputBorder(
                    borderSide:const BorderSide(
                      color: Colors.cyan,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Gender ",
                  hintText: "enter your gender",
                ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'please enter your gender';
                    }
                    else{
                      return null;
                    }
                  }
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await firebaseAuth.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passswordController.text);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>homepage()));
                    }
                    on FirebaseAuthException catch (e) {
                      if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('The account already exists for that email.'),
                          ),
                        );
                      }
                    }
                  }
                },
                child: const Text('register'),
              ),


              TextButton(
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                  },
                  child: const Text("already have an account.login here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
