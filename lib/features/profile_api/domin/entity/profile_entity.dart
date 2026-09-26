import 'package:app/features/auth/domin/entities/user_entity.dart';

class ProfileEntity {
  final UserEntity user;
  final List<int> watchListIds;
  final List<int> historyIds;

  ProfileEntity({
    required this.user,
    required this.watchListIds,
    required this.historyIds,
  });
}