import 'package:mockito/annotations.dart';
import 'package:afinz_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:afinz_app/features/app/presentation/pages/balance/domain/repositories/balance_repository.dart';

@GenerateMocks([
  ProfileRepository,
  BalanceRepository,
])
void main() {}
