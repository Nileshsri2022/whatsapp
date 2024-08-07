import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/common/widgets/custom_button.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          // it tells to build the BuildFn again
          setState(() {
            country = _country;
          });
        });
  }

  // below function call the AuthController -> AuthRepository -> Firebase
  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    print("inside login_screen.dart"+phoneNumber+" "+country!.toString());

    // to get access to ref convert whole class to consumer
    // ref is used to interact with Providers
    // provider ref interact provider with provider
    // widget ref interact widget with provider
    if (country != null && phoneNumber.isNotEmpty) {

      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${country!.phoneCode}${phoneNumber}');
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter your phone number'),
        elevation: 0,
        // override the global appBarTheme
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Whatsapp will need to verify your phone number'),
              const SizedBox(
                height: 10,
              ),
              // the reason we are not using custom button it uses ElevatedButton
              TextButton(
                onPressed: pickCountry,
                child: Text('Pick Country'),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  if (country != null) Text('+${country!.phoneCode}'),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                        controller: phoneController,
                        decoration: InputDecoration(hintText: 'phone number')),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.56,
              ),
              SizedBox(
                width: 90,
                child: CustomButton(text: 'NEXT', onPressed: sendPhoneNumber),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// need to setup SHA key when you login using google and phone no and firebase deeplinking
