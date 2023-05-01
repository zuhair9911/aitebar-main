part of 'search_cubit.dart';

abstract class SearchState {
  final String query;
  final int activeIndex;
  final bool isSearching;

  const SearchState({this.query = '', this.activeIndex = 0, this.isSearching = false});

  SearchState copyWith({String? query, int? activeIndex, bool? isSearching});
}

class SearchUpdateState extends SearchState {
  const SearchUpdateState({String query = '', int activeIndex = 0, bool isSearching = false})
      : super(isSearching: isSearching, query: query, activeIndex: activeIndex);

  @override
  SearchUpdateState copyWith({String? query, int? activeIndex, bool? isSearching}) {
    return SearchUpdateState(
      isSearching: isSearching ?? this.isSearching,
      query: query ?? this.query,
      activeIndex: activeIndex ?? this.activeIndex,
    );
  }
}
