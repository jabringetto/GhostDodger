import GoogleMobileAds
import UIKit

final class AdMobManager: NSObject {
    static let shared = AdMobManager()
    
    // Replace these with your actual AdMob unit IDs
    private let interstitialAdUnitID = "ca-app-pub-5684622995422684/5758656380"
    private let rewardedAdUnitID = "ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyy"
    
    private var interstitialAd: GADInterstitialAd?
    private var rewardedAd: GADRewardedAd?
    
    private override init() {
        super.init()
        setupAds()
    }
    
    func setupAds() {
        // Initialize the Google Mobile Ads SDK
        GADMobileAds.sharedInstance().start { status in
            // Load the first interstitial ad
            self.loadInterstitialAd()
            // Load the first rewarded ad
            self.loadRewardedAd()
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
    
    private func loadRewardedAd() {
        let request = GADRequest()
        GADRewardedAd.load(
            withAdUnitID: rewardedAdUnitID,
            request: request
        ) { [weak self] ad, error in
            if let error = error {
                print("Failed to load rewarded ad: \(error.localizedDescription)")
                return
            }
            self?.rewardedAd = ad
        }
    }
    
    func showInterstitial(from viewController: UIViewController, completion: (() -> Void)? = nil) {
        guard let interstitialAd = interstitialAd else {
            print("Interstitial ad not ready")
            completion?()
            return
        }
        
        interstitialAd.present(fromRootViewController: viewController) {
            completion?()
            self.loadInterstitialAd() // Load the next ad
        }
    }
    
    func showRewardedAd(from viewController: UIViewController, completion: @escaping (Bool) -> Void) {
        guard let rewardedAd = rewardedAd else {
            print("Rewarded ad not ready")
            completion(false)
            return
        }
        
        rewardedAd.present(fromRootViewController: viewController) { [weak self] in
            // User earned reward
            completion(true)
            self?.loadRewardedAd() // Load the next ad
        }
    }
} 
