import 'package:dio/dio.dart';

class AppError implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  AppError({
    required this.message,
    this.code,
    this.originalError,
  });

  factory AppError.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppError(
          message: 'Erro de conexão. Verifique sua internet.',
          code: 'CONNECTION_ERROR',
          originalError: error,
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] as String?;
        
        switch (statusCode) {
          case 400:
            return AppError(
              message: message ?? 'Dados inválidos. Verifique as informações.',
              code: 'BAD_REQUEST',
              originalError: error,
            );
          case 401:
            return AppError(
              message: 'Sessão expirada. Faça login novamente.',
              code: 'UNAUTHORIZED',
              originalError: error,
            );
          case 403:
            return AppError(
              message: 'Operação não permitida.',
              code: 'FORBIDDEN',
              originalError: error,
            );
          case 404:
            return AppError(
              message: message ?? 'Recurso não encontrado.',
              code: 'NOT_FOUND',
              originalError: error,
            );
          case 500:
            return AppError(
              message: 'Erro interno do servidor. Tente novamente mais tarde.',
              code: 'SERVER_ERROR',
              originalError: error,
            );
          default:
            return AppError(
              message: message ?? 'Erro ao realizar operação. Tente novamente.',
              code: 'UNKNOWN_ERROR',
              originalError: error,
            );
        }
      case DioExceptionType.cancel:
        return AppError(
          message: 'Operação cancelada.',
          code: 'CANCELLED',
          originalError: error,
        );
      default:
        return AppError(
          message: 'Erro ao realizar operação. Tente novamente.',
          code: 'UNKNOWN_ERROR',
          originalError: error,
        );
    }
  }

  factory AppError.unknown(dynamic error) {
    return AppError(
      message: 'Erro inesperado. Tente novamente mais tarde.',
      code: 'UNKNOWN_ERROR',
      originalError: error,
    );
  }

  @override
  String toString() => message;
} 