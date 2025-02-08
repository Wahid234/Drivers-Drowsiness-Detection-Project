import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String message;
  final int status;

  const Message({
    required this.message,
    required this.status,
  });

  @override
  List<Object?> get props => [message, status];

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['Message'],
      status: map['Status'],
    );
  }
}