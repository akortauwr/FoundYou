import 'package:flutter/material.dart';
import 'package:found_you_app/utils/result.dart';

abstract class Command<T> extends ChangeNotifier {
  bool _running = false;
  bool get running => _running;

  Result<T>? _result;
  Result<T>? get result => _result;

  bool get error => _result is Error;
  bool get completed => _result is Ok;

  void clearResult() {
    if (_result == null) return;
    _result = null;
    notifyListeners();
  }

  Future<void> _execute(Future<Result<T>> Function() action) async {
    if (running) return;

    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } catch (e) {
      _result = Result.error(Exception('Task failed: $e'));
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

class Command0<T> extends Command<T> {
  Command0(this._action);

  final Future<Result<T>> Function() _action;

  Future<void> execute() async {
    await _execute(_action);
  }
}

class Command1<T, A> extends Command<T> {
  Command1(this._action);

  final Future<Result<T>> Function(A) _action;

  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}

class CommandN<T> extends Command<T> {
  CommandN(this._action);

  final Future<Result<T>> Function(List<dynamic>) _action;

  Future<void> execute(List<dynamic> arguments) async {
    await _execute(() => _action(arguments));
  }
}
