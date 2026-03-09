import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'user_info_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final lifeStoryController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final nameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final emailFocus = FocusNode();
  final lifeStoryFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmFocus = FocusNode();

  bool _hidePass = true;
  bool validatePhoneNumber(String input) {
    final phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return phoneExp.hasMatch(input);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    lifeStoryController.dispose();
    passwordController.dispose();
    confirmController.dispose();

    nameFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    confirmFocus.dispose();

    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserInfoPage(
            name: nameController.text,
            email: emailController.text,
            phone: phoneController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text(
          "Register Form",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                focusNode: nameFocus,
                decoration: InputDecoration(
                  labelText: 'Full Name *',
                  hintText: 'What do people call you?',
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: Icon(Icons.delete_outline, color: Colors.red),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name cannot be empty";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(emailFocus),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                focusNode: phoneFocus,
                decoration: InputDecoration(
                  labelText: 'Phone Number *',
                  hintText: 'Where can we reach you?',
                  helperText: 'Phone format: (XXX)XXX-XXX',
                  prefixIcon: Icon(Icons.call),
                  suffixIcon: Icon(Icons.delete_outline, color: Colors.red),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                keyboardType: TextInputType.phone,
                // inputFormatters: [
                //   FilteringTextInputFormatter.digitsOnly
                // ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone number required";
                  }
                  if (!validatePhoneNumber(value)) {
                    return "Format: (XXX)XXX-XXXX";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(passwordFocus),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                focusNode: emailFocus,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required";
                  }
                  if (!value.contains("@")) {
                    return "Invalid email";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(phoneFocus),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: lifeStoryController,
                focusNode: lifeStoryFocus,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Life Story",
                  helperText: "Keep it short, this is just a demo",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                focusNode: passwordFocus,
                obscureText: _hidePass,
                maxLength: 8,
                decoration: InputDecoration(
                  labelText: 'Password *',
                  hintText: 'Enter the password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                    icon: Icon(
                      _hidePass ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  icon: Icon(Icons.security),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password required";
                  }
                  if (value.length < 6) {
                    return "Minimum 6 characters";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(confirmFocus),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: confirmController,
                focusNode: confirmFocus,
                obscureText: _hidePass,
                maxLength: 8,
                decoration: const InputDecoration(
                  labelText: "Confirm Password *",
                  prefixIcon: Icon(Icons.edit),
                ),
                validator: (value) {
                  if (value != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: LinearBorder(),
                ),
                child: const Text(
                  "Submit Form",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
