import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'sign up.dart';
class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}
class _loginState extends State<login> {
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  final formKey=GlobalKey <FormState>();
  final nameController= TextEditingController();
  final emailController=TextEditingController();
  final passswordController=TextEditingController();
  final genderController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('register'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
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
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    await firebaseAuth.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passswordController.text,
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>homepage()));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      ScaffoldMessenger.of(context).showSnackBar (
                        SnackBar(
                          content: Text('Email does not exist.'),
                        ),
                      );
                    } else if (e.code == 'wrong-password') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Incorrect password.'),
                        ),
                      );
                    }
                  }
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed:(){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>register()));
              },
              child: const Text("register here"),
            ),
          ],
        ),
      ),
    );
  }
}
