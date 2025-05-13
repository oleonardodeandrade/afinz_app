import 'package:afinz_app/core/config/http_client.dart';
import 'package:dio/dio.dart';

abstract class TransferRemoteDatasource {
  Future<void> transfer({
    required int value,
    required int agency,
    required int account,
  });

  Future<String> validateAgencyAccount({
    required int agency,
    required int account,
  });
}

class TransferRemoteDatasourceImpl implements TransferRemoteDatasource {
  final Dio dio;

  TransferRemoteDatasourceImpl([Dio? dio]) : dio = dio ?? HttpClient.dio;

  @override
  Future<void> transfer({
    required int value,
    required int agency,
    required int account,
  }) async {
    try {
      final response = await dio.post(
        '/transfer',
        data: {'value': value, 'agency': agency, 'account': account},
      );

      if (response.statusCode! >= 400) {
        throw Exception(response.data['message'] ?? 'Falha ao transferir');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Falha ao transferir');
    }
  }

  @override
  Future<String> validateAgencyAccount({
    required int agency,
    required int account,
  }) async {
    try {
      final response = await dio.get(
        '/consult-agency-account/$agency/$account',
      );

      if (response.statusCode! >= 400) {
        throw Exception(response.data['message'] ?? 'Agência/conta inválida');
      }

      return response.data['name'] as String;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Agência/conta inválida');
    }
  }
}
