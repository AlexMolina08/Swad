

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/repository/swad_repository.dart';

final notificationsProvider = FutureProvider<String>(
      (ref) async {

    final SwadRepository repo = SwadRepository(ref.read);

    final content = await repo.getNotifications();

    print(content);

    return content;
  },
);