//
//  AdProvider.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 23.11.2023.
//

import SwiftUI
import GoogleMobileAds

final class AdProvider: NSObject {
    var onFailedToLoadAd: (() -> Void)?
    
    func loadInterstitial(_ completion: ((GADInterstitialAd) -> Void)? = nil){
        let request = GADRequest()
        
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3718032709475246/8709013500", request: request) { [weak self] (ad, error) in
            guard error == nil else {
                print("Failed txo load interstitial ad: \(error!.localizedDescription)")
                
                self?.onFailedToLoadAd?()
                return
            }
            
            guard let ad = ad else {
                return
            }
            
            completion?(ad)
        }
    }
    
    func showAd(){
        guard let rootViewController = UIApplication.shared.firstWindow?.rootViewController else {
            return
        }
        
        loadInterstitial { (ad) in
            ad.present(fromRootViewController: rootViewController)
        }
    }
}
