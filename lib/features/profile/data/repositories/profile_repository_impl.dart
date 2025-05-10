import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepositoryImpl(this.remoteDatasource);

  @override
  Future<Profile> getProfile() {
    return remoteDatasource.getProfile();
  }
}
