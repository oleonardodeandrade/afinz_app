import 'package:dio/dio.dart';
import '../../domain/entities/profile.dart';

abstract class ProfileRemoteDatasource {
  Future<Profile> getProfile();
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final Dio dio;

  ProfileRemoteDatasourceImpl(this.dio);

  @override
  Future<Profile> getProfile() async {
    final response = await dio.get('/profile');
    final data = response.data;
    return Profile(
      name: data['name'],
      agency: data['agency'],
      account: data['account'],
    );
  }
}
