import "package:logger/logger.dart";

// for pretty printing and better readability of log messages 
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // don’t show stack trace
    errorMethodCount: 5, // show stack trace for errors only
    lineLength: 50, // wrap log messages after 50 characters
    colors: true, // colorize log messages
    printEmojis: true, // print an emoji for each log message
    dateTimeFormat: DateTimeFormat.dateAndTime, // show date and time in log messages
  ),
);