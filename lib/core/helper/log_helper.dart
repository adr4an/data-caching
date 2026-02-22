import "package:logger/logger.dart";

// Csutom logger instance with specific configuration
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // number of method calls to be displayed
    errorMethodCount: 5, // number of method calls if stacktrace is provided
    lineLength: 50, // width of the output
    colors: true, // Colorful log messages
    printEmojis: true, // Print an emoji for each log message
    dateTimeFormat: DateTimeFormat.dateAndTime, // Should each log print contain a timestamp
  ),
);