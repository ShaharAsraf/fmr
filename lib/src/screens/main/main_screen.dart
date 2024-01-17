import 'package:flutter/material.dart';
import 'package:fmr/src/blocs/main/main_bloc_provider.dart';
import 'package:fmr/src/utils/enums.dart';
import 'package:fmr/src/widgets/my_app_bar.dart';
import 'widgets/confirmation_stage.dart';
import 'widgets/finish_stage.dart';
import 'widgets/init_stage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const MyAppBar(), body: _renderMainScreen());
  }

  Widget _renderMainScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Center(
        child: StreamBuilder<VerificationStage>(
            stream: MainBlocProvider.of(context).verificationStageStream,
            builder: (context, AsyncSnapshot<VerificationStage> snapshot) {
              if (snapshot.data == null || snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: _renderStage(snapshot.data!),
              );
            }),
      ),
    );
  }

  Widget _renderStage(VerificationStage stage) {
    switch (stage) {
      case VerificationStage.initial:
        return const InitStage();
      case VerificationStage.confirmation:
        return const ConfirmationStage();
      case VerificationStage.finish:
        return const FinishStage();
    }
  }
}
