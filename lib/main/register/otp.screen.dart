import 'package:app_mobile/main/register/register.page.dart';
import 'package:app_mobile/repository/authentication.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'layout.register.dart';

class OtpScreen extends StatefulWidget {
  final DataRegister dataRegister;
  const OtpScreen({super.key, required this.dataRegister});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  OtpFieldController otpController = OtpFieldController();
  var value = "";
  @override
  Widget build(BuildContext context) {
    return LayoutRegister(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              height: 40,
              child: OTPTextField(
                  controller: otpController,
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 40,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 4,
                  style: const TextStyle(fontSize: 17),
                  onChanged: (pin) {},
                  onCompleted: (pin) {
                    value = pin;
                  }),
            ),
          ],
        ),
      ),
      namePage: 'Mã OTP!',
      subPage: 'Nhập mã OTP gồm 6 ký tự bạn nhận được!',
      buttonName: 'Xác nhận',
      onTap: () async {
        if (await myauth.verifyOTP(otp: value) == true) {
         context.read<AuthenticationRepository>().register(email: widget.dataRegister.email, password: widget.dataRegister.password, name: widget.dataRegister.name);
          // Navigator.push<void>(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => LoginScreen(email: widget.email),
          //   ),
          // );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("OTP không đúng"),
          ));
        }
      },
    );
  }
}
