import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/providers/search_notifier.dart';
import 'package:untitled/repository/swad_repository.dart';
import 'package:untitled/states/search_state.dart';



final searchNotifierProvider = StateNotifierProvider<SearchNotifier,SearchState>( (ref) {
  return SearchNotifier(SwadRepository(ref.read));
});
