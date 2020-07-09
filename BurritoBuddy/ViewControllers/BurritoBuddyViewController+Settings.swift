//
//  BurritoBuddyViewController+Settings.swift
//  BurritoBuddy
//
//  Created by Robert Brennan on 7/9/20.
//  Copyright © 2020 Creatility. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

// MARK: - HELPER FUNCTION

extension BurritoBuddyViewController{

    // MARK: - PERMISSION & ERROR LOGIC
    func askLocationPermissions(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

    func sendToSettings(shouldSendToSettings: Bool){
        let alertController = UIAlertController (title: "Location Services Enabled!", message: "You're good to go, You're location will update automatically!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        if shouldSendToSettings{
            alertController.title = "Location services are not enabled!"
            alertController.message = "Go to settings?"
            alertController.addAction(settingsAction)
            alertController.addAction(cancelAction)
        }
        else{
            alertController.addAction(okayAction)
        }
        present(alertController, animated: true, completion: nil)
    }

    func showErrorView(shouldShow: Bool){
        if shouldShow{
            errorView.isHidden = false
        }
        else{
            errorView.isHidden = true
        }
    }

}
