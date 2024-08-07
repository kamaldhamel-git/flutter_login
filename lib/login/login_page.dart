import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? isSelected = false;

  // creating object for provide or control values to the validator.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //for custom validation with TextField.
  bool isEmailInvalid = false;

  //key for form validation
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //form ko state hunxw so <FormState> use greko.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 50, 50, 20),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 40,
              ),
//---------- Form Section -------------//
              Form(
                key:
                    _formKey, //Key is required for validation with TextFormField.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType:
                          TextInputType.number, // number keyboard dekhaunw.
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                      ], // yesle input ma number mattra linxw no copay paste of other than number is accepted.
                      controller: _emailController, //for email validation
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        fillColor: Colors.white,
                        prefixIconColor: Colors.white,
                        hintText: 'Enter your Email',
                        hintStyle: TextStyle(color: Colors.grey[300]),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    //logic for email validation
                    if (isEmailInvalid) const Text("Email is Invalid"),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController, //for password validation
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        fillColor: Colors.white,
                        prefixIconColor: Colors.white,
                        hintText: 'Enter your Password',
                        hintStyle: TextStyle(color: Colors.grey[300]),
                        border: const OutlineInputBorder(),
                      ),
                      /*for form validation with validator | formkey le 
                      button click grda validate grnw vnepaxi tesle yeslai 
                      validate grxw.*/
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Empty password';
                        } else if (value.length < 6) {
                          return 'Password is too short';
                          //we can add more validation logics. | regex use grerw grnw ni sakinxw.
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forget Passowrd?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20, //for space between the widgets.
                    ),
                    Row(
                      children: [
                        Checkbox(
                          //for color and width of boderline of checkbox.
                          side: const BorderSide(
                            width: 2,
                            color: Colors.white,
                          ),
                          activeColor: Colors.green,
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              isSelected = value;
                            });
                          },
                        ),
                        const Text(
                          "Remember me",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // foregroundColor: Colors.black,
                        fixedSize: const Size.fromWidth(300),
                      ),
                      onPressed: () {
                        //email ko text empty ho vani mathiko "Email is invalid" vanni mgs display hunxw.
                        if (_emailController.text.isEmpty) {
                          isEmailInvalid = true;
                          //for leting know the widget that the state is change by rebuilding the whole widgets.
                          setState(() {});
                        } /* The mgs don't dislay instantly only displays when the app reload, means we need setState() */

                        //password validation ko | formkey ko currentstate lai validate gar.
                        if (_formKey.currentState!.validate()) {
                          //aaba validate vyepxi value chaiyema
                          debugPrint(_emailController
                              .text); //for printing what user type on email text field.
                          debugPrint(_passwordController.text);
                          //validation vyepaxi home page ma navigate huni and pushReplacementNamed le chai feri back to login page nvyerw app lai off grxw.
                          Navigator.pushReplacementNamed(context, "/homePage");
                        }
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Expanded(child: child)
                        const Text(
                          'Don\'t have An Account?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
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
