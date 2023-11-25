enum MessageType { none, info, warning, success, error }

abstract class Message {
  MessageType get type;
  String get title;
  String get body;
}

class NoneMessage implements Message {
  @override
  MessageType get type => MessageType.none;

  @override
  String get title => '';

  @override
  String get body => '';

  @override
  String toString() => '[${type.toString()}] >>> $title: $body';
}

class InfoMessage implements Message {
  final String _title;
  final String _body;

  InfoMessage(this._title, this._body);

  @override
  MessageType get type => MessageType.info;

  @override
  String get title => _title;

  @override
  String get body => _body;

  @override
  String toString() => '[${type.toString()}] >>> $title: $body';
}

class WarningMessage implements Message {
  final String _title;
  final String _body;

  WarningMessage(this._title, this._body);

  @override
  MessageType get type => MessageType.warning;

  @override
  String get title => _title;

  @override
  String get body => _body;

  @override
  String toString() => '[${type.toString()}] >>> $title: $body';
}

class SuccessMessage implements Message {
  final String _title;
  final String _body;

  SuccessMessage(this._title, this._body);

  @override
  MessageType get type => MessageType.success;

  @override
  String get title => _title;

  @override
  String get body => _body;

  @override
  String toString() => '[${type.toString()}] >>> $title: $body';
}

class ErrorMessage implements Message {
  final String _title;
  final String _body;

  ErrorMessage(this._title, this._body);

  @override
  MessageType get type => MessageType.error;

  @override
  String get title => _title;

  @override
  String get body => _body;

  @override
  String toString() => '[${type.toString()}] >>> $title: $body';
}
