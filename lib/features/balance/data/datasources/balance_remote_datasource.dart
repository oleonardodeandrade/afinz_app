import 'package:dio/dio.dart';

abstract class BalanceRemoteDatasource {
  Future<int> getBalance();
}

class BalanceRemoteDatasourceImpl implements BalanceRemoteDatasource {
  final Dio dio;

  BalanceRemoteDatasourceImpl(this.dio);

  @override
  Future<int> getBalance() async {
    final response = await dio.get('/balance');
    return response.data['balance'];
  }
}
