part of '../provider_package.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestaurantDetailProvider(this._apiService);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();
  RestaurantDetailResultState get resultState => _resultState;

  RestaurantDetailResultState _reviewState = RestaurantDetailNoneState();
  RestaurantDetailResultState get reviewState => _reviewState;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiService.getRestaurantDetail(id);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailResultLoadedState(result.restaurant);
        _reviewState =
            RestaurantDetailRewiewsState(result.restaurant.customerReviews);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantDetailErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<String?> fetchReviews(String id, String name, String review) async {
    try {
      // State tidak lagi diubah menjadi Loading / Error agar daftar Review Card di UI tidak menghilang

      // ==========================================
      // 1. Cek moderasi AI terlebih dahulu
      // ==========================================
      final moderationResult = await _apiService.checkModeration(review);
      
      final String status = moderationResult['status'] ?? 'positif'; 
      if (status == 'negatif') {
         // HENTIKAN EKSEKUSI, kembalikan alasan ke pemanggil (UI) untuk dijadikan pop-up
         return moderationResult['alasan'] ?? 'Komentar tidak pantas.';
      }

      // ==========================================
      // 2. Jika Positif, teruskan ke API Dicoding
      // ==========================================
      final result = await _apiService.sendReview(id, name, review);
      if (result.error) {
        // Kembalikan pesan error dari API tanpa merusak UI review cards
        return result.message;
      } else {
        // Jika berhaisl, PERBARUI data reviews di UI dengan data terbaru
        _reviewState = RestaurantDetailRewiewsState(result.customReviews);
        notifyListeners();
        return null; // Return null menandakan proses SUKSES
      }
    } catch (e) {
      // Menangkap error jika API AI mati atau API Dicoding gagal
      return e.toString();
    }
  }
}
