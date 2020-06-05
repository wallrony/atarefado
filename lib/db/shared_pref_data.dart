import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefData {
  final _introPageShownKey = 'ALREADY_VIEW_INTRO_PAGE';

  setIntroPageShown() async {
    SharedPreferences pref = await _getSharedPref;

    pref.setBool(_introPageShownKey, true);
  }

  getIntroPageShown() async {
    SharedPreferences pref = await _getSharedPref;

    bool result = pref.getBool(_introPageShownKey);

    return result;
  }

  get _getSharedPref => SharedPreferences.getInstance();
}