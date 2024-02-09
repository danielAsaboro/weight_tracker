import 'dart:developer' as dev_tools;

extension Log on Object {
  void log() => dev_tools.log(toString());
}
