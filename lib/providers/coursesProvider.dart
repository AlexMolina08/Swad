import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/models/course_model.dart';
import 'package:untitled/providers/auth_provider.dart';
import 'package:untitled/repository/swad_repository.dart';
import 'package:untitled/states/auth_state.dart';

// Provider del Swad Repository

final courseListProvider = FutureProvider<List<Course>>(
  (ref) async {
    final SwadRepository repo = SwadRepository(ref.read);

    final content = await repo.getCourseList();

    return content;
  },
);
