import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:app/utilities/config.dart';

class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class NetworkService {
  final String _baseUrl = Config.hostName;

  Future<dynamic> request(
    String method,
    String accessPoint,
    Map<String, String> params,
    List<String> urlParams,
  ) async {
    var responseJson;

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '<Your token>'
    };

    try {
      var response;
      switch (method) {
        case 'GET':
          response = await http.get(
            Uri.parse(_baseUrl + accessPoint),
            headers: headers,
          );
          break;
        case 'POST':
          response = await http.post(Uri.parse(_baseUrl + accessPoint));
          break;
        case 'DELETE':
          response = await http.delete(Uri.parse(_baseUrl + accessPoint));
          break;
        case 'PUT':
          response = await http.put(Uri.parse(_baseUrl + accessPoint));
          break;
        case 'PATCH':
          response = await http.patch(Uri.parse(_baseUrl + accessPoint));
          break;
        default:
          throw FetchDataException('No Function found');
      }
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  // Future<dynamic> get(
  //   String accessPoint,
  //   Map<String, String> params,
  //   List<String> urlParams,
  // ) async {
  //   var responseJson;

  //   try {
  //     final response = await http.get(Uri.parse(_baseUrl + accessPoint));
  //     responseJson = _returnResponse(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }

  // Future<dynamic> post(
  //   String accessPoint,
  //   Map<String, String> params,
  //   List<String> urlParams,
  // ) async {
  //   var responseJson;

  //   try {
  //     final response = await http.post(Uri.parse(_baseUrl + accessPoint));
  //     responseJson = _returnResponse(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }

  // Future<dynamic> delete(
  //   String accessPoint,
  //   Map<String, String> params,
  //   List<String> urlParams,
  // ) async {
  //   var responseJson;

  //   try {
  //     final response = await http.delete(Uri.parse(_baseUrl + accessPoint));
  //     responseJson = _returnResponse(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }

  // Future<dynamic> put(
  //   String accessPoint,
  //   Map<String, String> params,
  //   List<String> urlParams,
  // ) async {
  //   var responseJson;

  //   try {
  //     final response = await http.put(Uri.parse(_baseUrl + accessPoint));
  //     responseJson = _returnResponse(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }

  // Future<dynamic> patch(
  //   String accessPoint,
  //   Map<String, String> params,
  //   List<String> urlParams,
  // ) async {
  //   var responseJson;

  //   try {
  //     final response = await http.patch(Uri.parse(_baseUrl + accessPoint));
  //     responseJson = _returnResponse(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
