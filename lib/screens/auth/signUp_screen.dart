import 'package:crypto_tracker/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final Function toggleScreen;

  const SignUp({Key? key, required this.toggleScreen}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<AuthServices>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        title: Text(
          'CRYPTOWATCHER',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          alignment: Alignment.centerLeft,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
        ),

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Create a new account to continue',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    validator: (val) => val!.isNotEmpty
                        ? null
                        : "Please enter an email address",
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 2.0),
                      ),
                      hintText: "Email",
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _passwordController,
                    validator: (val) => val!.length < 6
                        ? "Enter more than 6 char"
                        : null,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 2.0),
                      ),
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  MaterialButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        print("Email: ${_emailController.text}");
                        print("Email: ${_passwordController.text}");
                        await signInProvider.signUp(_emailController.text.trim(),
                            _passwordController.text.trim());
                      }
                    },
                    height: 60,
                    minWidth: signInProvider.isLoading 
                        ? null 
                        : double.infinity,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: signInProvider.isLoading 
                        ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.amber))
                        : Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () => widget.toggleScreen(),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  if(signInProvider.errorMessage != null)
                    Container(
                      color: Colors.amberAccent,
                      child: ListTile(
                          title: Text(signInProvider.errorMessage!,
                            style: TextStyle(
                              color: Colors.black,
                            ),),
                          leading: Icon(Icons.error),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => signInProvider.setMessage(null),
                          )
                      ),
                    )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
