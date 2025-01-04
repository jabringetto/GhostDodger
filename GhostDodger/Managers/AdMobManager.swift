import GoogleMobileAds
import UIKit

final class AdMobManager: NSObject {
    static let shared = AdMobManager()
    
    // Replace this with your actual AdMob unit ID
    private let interstitialAdUnitID = "ca-app-pub-5684622995422684/5758656380"
    private var interstitialAd: GADInterstitialAd?
    
    private override init() {
        super.init()
        setupAds()
    }
    
    func setupAds() {
        // Initialize the Google Mobile Ads SDK
        GADMobileAds.sharedInstance().start { status in
            self.loadInterstitialAd()
        }
    }
    
    private func loadInterstitialAd() {
        let request = GADRequest()
        GADInterstitialAd.load(
            withAdUnitID: interstitialAdUnitID,
            request: request
        ) { [weak self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad: \(error.localizedDescription)")
                return
            }
            self?.interstitialAd = ad
        }
    }

    func presentInterstitialAd(from viewController: UIViewController, completion: (() -> Void)? = nil) {
        if let ad = interstitialAd {
            ad.present(fromRootViewController: viewController)
            completion?()
            self.loadInterstitialAd() // Load the next ad
        } else {
            print("Ad wasn't ready.")
            completion?()
        }
    }
}
