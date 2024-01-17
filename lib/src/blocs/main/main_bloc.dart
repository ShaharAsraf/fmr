import 'package:fmr/src/utils/enums.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc {
  static MainBloc? instance;
  factory MainBloc() {
    if (instance == null) {
      instance = MainBloc._();
      instance!.init();
    }
    return instance!;
  }

  MainBloc._() : super();
  final _verificationStageSubject = BehaviorSubject<VerificationStage>.seeded(VerificationStage.initial);
  Stream<VerificationStage> get verificationStageStream => _verificationStageSubject.stream;

  void onStageChange() {
    if (_verificationStageSubject.value == VerificationStage.initial) {
      _verificationStageSubject.sink.add(VerificationStage.confirmation);
    } else if (_verificationStageSubject.value == VerificationStage.confirmation) {
      _verificationStageSubject.sink.add(VerificationStage.finish);
    }
  }

  void init() {}

  dispose() {
    _verificationStageSubject.close();
  }
}
