part of '../app_router.dart';

class PathParameters {
  final RootTab rootTab;

  PathParameters({
    this.rootTab = RootTab.home,
  });

  Map<String, String> toMap({required,  }) {
    return {
      'root_tab': rootTab.value,
    };
  }
}
