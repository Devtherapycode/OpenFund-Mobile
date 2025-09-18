import 'package:flutter/foundation.dart';

/// Main application state provider
class AppStateProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;
  
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void setError(String? error) {
    _error = error;
    notifyListeners();
  }
  
  void clearError() {
    _error = null;
    notifyListeners();
  }
  
  void reset() {
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}