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

abstract class NetworkService {

  Future<dynamic> request({
    required String method,
    required String accessPoint,
    Map<String, String>? body,
    List<String>? urlParams,
    List<String>? accessPointParams}
  ) async {
    const String _baseUrl = Config.hostName;
    String endPoint = _returnEndPoint(Config.endPoints[accessPoint] as String);
    Map<String, String> headers = { 'Content-type': 'application/json', 'Accept': 'application/json', 'Authorization': '<Your token>' };
    http.Response response;

    try {
      switch (method) {
        case 'GET':
          response = await http.get(
            Uri.parse(_baseUrl + endPoint),
            headers: headers,
          );
          break;
        case 'POST':
          response = await http.post(
            Uri.parse(_baseUrl + endPoint),
            headers: headers,
            body: body
          );
          break;
        case 'DELETE':
          response = await http.delete(
            Uri.parse(_baseUrl + endPoint),
            headers: headers,
            body: body
          );
          break;
        case 'PUT':
          response = await http.put(
            Uri.parse(_baseUrl + endPoint),
            headers: headers,
            body: body
          );
          break;
        case 'PATCH':
          response = await http.patch(
            Uri.parse(_baseUrl + endPoint),
            headers: headers,
            body: body
          );
          break;
        default:
          throw FetchDataException('No Function found');
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch(error){
      throw FetchDataException('Error in request function -> ${error.toString()}');
    }
    return _returnResponse(response);
  }

  dynamic _returnResponse(http.Response response) {
    try {
      switch (response.statusCode) {
        case 200:
          return json.decode(response.body.toString());
        case 400:
          throw BadRequestException(response.body.toString());
        case 401:
        case 403:
          throw UnauthorisedException(response.body.toString());
        case 500:
        default:
          throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      } 
    } catch (error) {
      throw FetchDataException('Error in json.decode -> ${error.toString()}');
    }
  }

  String _returnEndPoint(String endPoint){
    return endPoint.toString();
  }
}
