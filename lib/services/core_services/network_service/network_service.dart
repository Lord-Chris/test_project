import 'dart:io';

import 'package:dio/dio.dart';

import '../../../models/general/failure.dart';
import 'i_network_service.dart';

class NetworkService extends INetworkService{
  final Dio _dio;

  final _headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  NetworkService({Dio? dio})
      : _dio = dio ?? Dio()
          ..options.receiveTimeout = const Duration(seconds: 60)
          ..options.sendTimeout = const Duration(seconds: 60)
          ..interceptors.addAll([
            // NetworkLoggerInterceptor(),
          ]);

  @override
  Future<dynamic> delete(String url,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      final res = await _dio.delete(
        url,
        data: body,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res.data;
      }
      throw Failure(message: res.statusMessage!);
    } on DioException catch (e) {
      throw convertDioException(e);
    } catch (e) {
      throw FallbackFailure(message: e.toString());
    }
  }

  @override
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      final res = await _dio.get(
        url,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res.data;
      }
      throw Failure(message: res.statusMessage!);
    } on DioException catch (e) {
      throw convertDioException(e);
    } catch (e) {
      throw FallbackFailure(message: e.toString());
    }
  }

  @override
  Future<dynamic> put(String url,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      final res = await _dio.put(
        url,
        data: body,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res.data;
      }
      throw Failure(message: res.statusMessage!);
    } on DioException catch (e) {
      throw convertDioException(e);
    } catch (e) {
      throw FallbackFailure(message: e.toString());
    }
  }

  @override
  Future<dynamic> post(String url,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      if (headers != null) {
        _headers.addAll(headers);
      }
      final res = await _dio.post(
        url,
        data: body,
        options: Options(headers: _headers),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res.data;
      }
      throw Failure(message: res.statusMessage!);
    } on DioException catch (e) {
      throw convertDioException(e);
    } catch (e) {
      throw FallbackFailure(message: e.toString());
    }
  }

  IFailure convertDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return InternetFailure(data: e);
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
        return Failure(
          message: e.response?.data['message'] ?? e.message ?? '',
          data: e.response?.data,
        );
      case DioExceptionType.unknown:
        if (e.error is SocketException) return InternetFailure(data: e);
        if (e.error is HandshakeException) return InternetFailure(data: e);
        return FallbackFailure(data: e);
      case DioExceptionType.badResponse:
        if ((e.response?.statusCode ?? 500) >= HttpStatus.internalServerError) {
          return ServerFailure(data: e.response?.data);
        }
        if (IFailure.isValidationFailure(e.response?.data)) {
          return ValidationFailure(data: e.response?.data);
        }
        return Failure.fromHttpErrorMap(e.response?.data);
    }
  }
}
