import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

enum LogUtilMode {
  debug, // 💚 DEBUG
  warning, // 💛 WARNING
  info, // 💙 INFO
  error, // ❤️ ERROR
}

String kLog(dynamic message, {LogUtilMode mode = LogUtilMode.debug}) {
  final nowTime = DateTime.now();

  if (kReleaseMode) {
    // release模式不打印
    return "";
  }
  // Chain.forTrace(StackTrace.current);
  var chain = Chain.forTrace(StackTrace.current);
  // 将 core 和 flutter 包的堆栈合起来（即相关数据只剩其中一条）
  chain =
      chain.foldFrames((frame) => frame.isCore || frame.package == "flutter");
  // 取出所有信息帧
  final frames = chain.toTrace().frames;
  // 找到当前函数的信息帧
  final idx = frames.indexWhere((element) => element.member == "kLog");
  if (idx == -1 || idx + 1 >= frames.length) {
    return "";
  }
  // 调用当前函数的函数信息帧
  final frame = frames[idx + 1];

  var modeStr = "";
  switch (mode) {
    case LogUtilMode.debug:
      modeStr = "💚 DEBUG";
      break;
    case LogUtilMode.warning:
      modeStr = "💛 WARNING";
      break;
    case LogUtilMode.info:
      modeStr = "💙 INFO";
      break;
    case LogUtilMode.error:
      modeStr = "❤️ ERROR";
      break;
  }

  final printStr =
      "🐖🐖🐖🐖 $nowTime $modeStr  ${frame.uri.toString().split("/").last}(${frame.line}) \n - $message \n 🐖🐖🐖🐖 ";
  print(printStr);
  return printStr;
}
