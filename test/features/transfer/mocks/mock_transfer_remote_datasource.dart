import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:afinz_app/features/transfer/data/datasources/transfer_remote_datasource.dart';

@GenerateMocks([
  TransferRemoteDatasource,
  Dio,
])
void main() {}
