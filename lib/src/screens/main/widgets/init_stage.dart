import 'package:flutter/material.dart';
import 'package:fmr/src/blocs/main/main_bloc_provider.dart';

class InitStage extends StatelessWidget {
  const InitStage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _renderTitle(),
        const SizedBox(height: 32),
        _renderSubtitle(),
        const SizedBox(height: 50),
        _renderBody(),
        const SizedBox(height: 32),
        _renderButton(context),
      ],
    );
  }

  Widget _renderTitle() {
    return const Text('שליחת קוד אימות', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22));
  }

  Widget _renderSubtitle() {
    return const Text(
      'שלחנו הודעה עם קוד חד פעמי לטלפון הנייד שלך',
      style: TextStyle(fontSize: 15),
      textAlign: TextAlign.center,
    );
  }

  Widget _renderBody() {
    return const Text('054-****431', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22));
  }

  Widget _renderButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          MainBlocProvider.of(context).onStageChange();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('שליחת קוד אימות', style: Theme.of(context).textTheme.headlineSmall),
        ));
  }
}
