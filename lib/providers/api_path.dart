const _prefix = '/api/v1';

class ApiPath {
  static const String login = '$_prefix/login';

  //market
  static const String symbolStatic = '/media/symbol_static_data.json';
  static const String symbolLatest = '$_prefix/market/symbolLatest';

  //community
  static const String feed = '$_prefix/community/feed';
}
