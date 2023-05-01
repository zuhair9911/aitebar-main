import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'search_state.dart';

@lazySingleton
class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchUpdateState());

  void onChanged(String value) {
    emit(state.copyWith(query: value.toLowerCase()));
  }

  void setActiveIndex(int index) {
    emit(state.copyWith(activeIndex: index, query: '', isSearching: false));
  }

  void clear() => emit(state.copyWith(query: '', isSearching: false));

  startSearching() => emit(state.copyWith(isSearching: true));

  stopSearching() => emit(state.copyWith(isSearching: false, query: ''));
}
