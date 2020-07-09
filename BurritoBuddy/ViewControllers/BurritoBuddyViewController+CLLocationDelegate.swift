//
//  BurritoBuddyViewController+CLLocationDelegate.swift
//  BurritoBuddy
//
//  Created by Robert Brennan on 7/8/20.
//  Copyright © 2020 Creatility. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import CoreLocation
import MBProgressHUD

// MARK: - CLLocationManagerDelegate
extension BurritoBuddyViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    let location = self.locationManager.location!
                    userLocation = self.locationManager.location?.coordinate
                    fetchNearbyBurritoPlaces(coordinate: location.coordinate){ [weak self] in
                    }
                    location.fetchCityAndState { city, state, error in
                        guard let city = city, let state = state, error == nil else { return }
                        print(city + ", " + state)
                        self.cityLabel.text = "\(city), \(state)"
                    }

                }
            }
        }
    }

    func fetchNearbyBurritoPlaces(coordinate: CLLocationCoordinate2D, completion: (() -> Void)?){
        MBProgressHUD.showAdded(to: view, animated: true)
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types: searchedTypes, keyword: keyword) { restaurants in
            if restaurants.count == 0 {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.burritoCollectionView.isHidden = true
                self.showErrorView(shouldShow: true)
                return
            }
            self.burritoRestaurants = restaurants
            completion?()
        }
    }
}

extension CLLocation {
    func fetchCityAndState(completion: @escaping (_ city: String?, _ state:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.administrativeArea, $1) }
    }
}
