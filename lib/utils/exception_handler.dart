class CustomException {
  final String? errorMessage;

  CustomException({this.errorMessage});

  factory CustomException.insufficientGas(String message) = InsufficientGasException;
  factory CustomException.wrongPassword(String message) =
      WrongPasswordException;
}


class InsufficientGasException extends CustomException {
  InsufficientGasException(
    this.message,
  ) : super(errorMessage: message);
  final String? message;
}

class WrongPasswordException extends CustomException {
  WrongPasswordException(
    this.message,
  ) : super(errorMessage: message);
  final String? message;
}