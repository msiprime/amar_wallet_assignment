abstract interface class HomeDataSource {
  Future<List<Map<String, dynamic>>> getCardData();
}
