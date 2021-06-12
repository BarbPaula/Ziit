import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  //Email regexp
  static String _emailRegex =
      r"(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|'(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*')@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])";

  static String _cpfRegex = r"/^\d{3}\.\d{3}\.\d{3}\-\d{2}$/";

  /// Verifica se a string é um e-mail válido.
  static bool isEmailValid(String email) {
    return RegExp(_emailRegex).hasMatch(email);
  }

  /// Verifica se o cpf é valido.
  static bool isCpfValid(String cpf) {
    if (cpf.length == 14) {
      cpf = cpf.replaceAll('.', '');
      cpf = cpf.replaceAll('-', '');

      //Verifica se é um cpf proibido
      bool forbidCpf = _blacklistedCPF(cpf);
      if (forbidCpf) {
        return false;
      }

      //Gerar o primeiro digito
      int baseNumber = 0;
      for (var i = 0; i < cpf.length - 2; i++) {
        baseNumber += int.parse(cpf[i]) * ((cpf.length - 1) - i);
      }

      int firstDigit = baseNumber * 10 % 11;
      firstDigit = firstDigit >= 10 ? 0 : firstDigit;

      //Gerar o segundo digito
      baseNumber = 0;
      for (var i = 0; i < cpf.length - 2; i++) {
        baseNumber += int.parse(cpf[i]) * ((cpf.length) - i);
      }
      baseNumber += firstDigit * 2;

      int secondDigit = baseNumber * 10 % 11;
      secondDigit = secondDigit >= 10 ? 0 : secondDigit;

      //Verifica se os digitos validadores é o mesmo
      String digits = firstDigit.toString() + secondDigit.toString();
      if (cpf.substring(9) == digits) {
        return true;
      }
    }

    return false;
  }

  static bool _blacklistedCPF(String cpf) {
    return cpf == '11111111111' ||
        cpf == '22222222222' ||
        cpf == '33333333333' ||
        cpf == '44444444444' ||
        cpf == '55555555555' ||
        cpf == '66666666666' ||
        cpf == '77777777777' ||
        cpf == '88888888888' ||
        cpf == '99999999999';
  }

  ///Formata DateTime
  static String formatDateTimeInStringFormated(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH:mm - dd/MM/yyyy');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  static DateTime formatStringToDateTime(String dateString) {
    DateTime tempDate = new DateFormat("dd/MM/yyyy - HH:mm").parse(dateString);
    return DateTime.parse(tempDate.toIso8601String());
  }
}
