import 'dart:io';
import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManager {
  ///- 앱이 처음 시작될 때 광고를 로드하고 캐싱하는 데 사용되는 최대 시간
  final Duration maxCacheDuration = const Duration(hours: 4);

  ///- 마지막으로 광고를 로드한 시간
  DateTime? _appOpenLoadTime;

  ///- nullable한 [AppOpenAd] 인스턴스
  AppOpenAd? _appOpenAd;

  ///- [AppOpenAd]가 현재 화면에 표시되고 있는지 여부
  bool _isShowingAd = false;

  ///- 실제 광고 단위 ID는 앱 테스트 환경에서 사용하면 부정 게시로 인해 차단될 수 있음
  ///- 안드로이드 테스트 단위 ID는 https://developers.google.com/admob/android/test-ads?hl=ko#sample_ad_units에서 확인 가능
  ///- iOS 테스트 단위 ID는 https://developers.google.com/admob/ios/test-ads?hl=ko#sample_ad_units에서 확인 가능
  ///- 앱 릴리즈 시에는 AdMob에서 발급받은 단위 ID를 사용해야하고 kReleaseMode를 사용해야함
  String adUnitId = Platform.isAndroid
      ? "ca-app-pub-3940256099942544/3419835294"
      : "ca-app-pub-3940256099942544/5662855259";

  ///- [AppOpenAd]를 로드하고 캐싱 작업을 수행
  void loadAd() {
    AppOpenAd.load(
      adUnitId: adUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          log("$ad AppOpenAd loaded");
          _appOpenLoadTime = DateTime.now();
          _appOpenAd = ad;
          _appOpenAd!.show();
        },
        onAdFailedToLoad: (error) {
          log("AppOpenAd failed to load: $error");
        },
      ),
    );
  }

  /// 이미 광고가 존재하거나 로드된 경우 `true`를 반환
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  ///- [AppOpenAd]를 표시하는 함수
  ///- [AppOpenAd]가 로드되지 않은 경우 [loadAd]를 호출
  ///- [AppOpenAd]가 로드된 경우 [AppOpenAd.show]를 호출
  void showAdIfAvailable() {
    if (!isAdAvailable) {
      log("Tried to show ad before available.");
      loadAd();
      return;
    }
    if (_isShowingAd) {
      log("Tried to show ad while already showing an ad.");
      return;
    }
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      log("Maximum cache duration exceeded. Loading another ad.");
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        log("$ad onAdShowedFullScreenContent");
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        log("$ad onAdFailedToShowFullScreenContent: $error");
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        log("$ad onAdDismissedFullScreenContent");
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}

///- 앱의 라이프 사이클 상태를 감지하는 클래스
class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleReactor({
    required this.appOpenAdManager,
  });

  ///- 앱의 라이프 사이클 상태를 감지하고 [AppOpenAdManager]를 통해 광고를 표시
  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  ///- 앱의 라이프 사이클 상태가 변경될 때 호출되는 함수
  void _onAppStateChanged(AppState appState) {
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable();
    }
  }
}
