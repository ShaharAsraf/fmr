import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:fmr/src/blocs/main/main_bloc_provider.dart';
import 'package:fmr/src/blocs/ui/ui_bloc_provider.dart';
import 'package:fmr/src/style/colors.dart';
import 'package:fmr/src/style/theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmationStage extends StatefulWidget {
  const ConfirmationStage({Key? key}) : super(key: key);

  @override
  State<ConfirmationStage> createState() => _ConfirmationStageState();
}

class _ConfirmationStageState extends State<ConfirmationStage> {
  final TextEditingController textEditingController = TextEditingController();
  final CountDownController countdownController = CountDownController();
  bool hasFinishedCountdown = false;
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  void _onContinueTap() {
    formKey.currentState?.validate();
    if (currentText.length != 6 || currentText != "123456") {
      errorController!.add(ErrorAnimationType.shake); // Triggering error shake animation
      setState(() => hasError = true);
    } else {
      MainBlocProvider.of(context).onStageChange();
    }
  }

  void _onResendTap() {
    snackBar("הקוד נשלח שוב!");
    countdownController.restart();
    setState(() {
      hasFinishedCountdown = false;
    });
  }

  void snackBar(String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              message!,
              style: Theme.of(context).textTheme.headlineSmall,
            )),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _renderTitle(),
            const SizedBox(height: 16),
            _renderSubTitle(),
            const SizedBox(height: 16),
            _renderPinCode(),
            _renderErrorText(),
            _renderContinueButton(),
            _renderResend(),
            const SizedBox(height: 16),
            _renderTimer(),
          ],
        ),
      ),
    );
  }

  Widget _renderTitle() {
    return const Text(
      'קוד אימות',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      textAlign: TextAlign.center,
    );
  }

  Widget _renderSubTitle() {
    return const Text(
      'נא להזין את הקוד שנשלח אליך במסרון או בהודעה קולית לטלפון הנייד שלך',
      style: TextStyle(fontSize: 15),
      textAlign: TextAlign.center,
    );
  }

  Widget _renderPinCode() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ValueListenableBuilder<bool>(
            valueListenable: UIBlocProvider.of(context).isDarkMode,
            builder: (context, isDark, child) {
              return PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: true,
                obscuringCharacter: '*',
                blinkWhenObscuring: true,
                animationType: AnimationType.scale,
                pinTheme: isDark ? darkPinTheme : lightPinTheme,
                cursorColor: isDark ? Colors.white : Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) {},
                onChanged: (value) {
                  setState(() {
                    currentText = value;
                  });
                },
              );
            }),
      ),
    );
  }

  Widget _renderErrorText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Text(
        hasError ? "קוד שגוי, נא הזן שנית" : "",
        style: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _renderResend() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "לא קיבלתי?",
            style: TextStyle(fontSize: 15),
          ),
          TextButton(
            onPressed: _onResendTap,
            child: const Text(
              "שלח לי שוב",
              style: TextStyle(
                color: buttonColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _renderTimer() {
    return CircularCountDownTimer(
      duration: 90,
      initialDuration: 0,
      controller: countdownController,
      width: 120,
      height: 120,
      ringColor: Colors.grey[300]!,
      ringGradient: null,
      fillColor: lightGreen,
      fillGradient: null,
      backgroundColor: buttonColor,
      backgroundGradient: null,
      strokeWidth: 12.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.MM_SS,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: true,
      onComplete: () {
        setState(() {
          hasFinishedCountdown = true;
        });
      },
    );
  }

  Widget _renderContinueButton() {
    final isActive = currentText.length == 6 && !hasFinishedCountdown;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
      decoration: BoxDecoration(
          color: isActive ? buttonColor : Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1.5),
            )
          ]),
      child: IgnorePointer(
        ignoring: !isActive,
        child: Opacity(
          opacity: isActive ? 1 : 0.4,
          child: ButtonTheme(
            height: 50,
            child: TextButton(
              onPressed: _onContinueTap,
              child: Center(
                child: Text(
                  "המשך",
                  style: TextStyle(
                    color: isActive ? Colors.white : lightTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
