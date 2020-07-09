//
//  NavigationBar.swift
//  BurritoBuddy
//
//  Created by Robert Brennan on 7/8/20.
//  Copyright © 2020 Creatility. All rights reserved.
//

import Foundation
import UIKit

extension BurritoBuddyViewController {

    func setupNavigationBarItems() {
        setupRemainingNavItems()
        setupLeftNavItem()
        setupRightNavItems()
    }

    private func setupRemainingNavItems() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: BurritoBuddyFont.HelveticaNeueBold.with(size: 25), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.heightAnchor.constraint(equalToConstant: 100)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = true

        let viewContainer = UIView()
        let titleLabel = UILabel()

        titleLabel.text = "Burrito Buddy"
        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: -50, y: 0, width: 170, height: 40)
        viewContainer.frame =  CGRect(x: -50, y: 0, width: 170, height: 80)
        viewContainer.addSubview(titleLabel)

        navigationItem.titleView = viewContainer

        let extraview = UIView()
        extraview.backgroundColor = UIColor.white
        extraview.layer.zPosition = -1
        extraview.frame = CGRect(x: 0, y: (navigationController?.navigationBar.frame.height)!, width: view.frame.width, height: 30)
        navigationController?.navigationBar.addSubview(extraview)
    }

    private func setupLeftNavItem() {
        let viewContainer = UIView()

        cityLabel.text = ""
        cityLabel.textColor = .darkGray
        cityLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        cityLabel.sizeToFit()
        cityLabel.frame = CGRect(x: 5, y: 50, width: self.view.frame.width, height: 80)
        viewContainer.frame =  CGRect(x: 0, y: 50, width: 170, height: 80)
        viewContainer.backgroundColor = UIColor.white
        viewContainer.addSubview(cityLabel)

        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: viewContainer)]
    }

    private func setupRightNavItems() {
        let viewContainer = UIView()
        viewContainer.frame =  CGRect(x: 0, y: 40, width: 40, height: 40)
        locationButton.setImage( #imageLiteral(resourceName: "LocationIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        locationButton.frame = CGRect(x: -10, y: 17, width: 40, height: 40)
        locationButton.backgroundColor = .clear
        locationButton.contentMode = .scaleAspectFit
        locationButton.backgroundColor = UIColor.white
        locationButton.layer.cornerRadius = 0.5 * locationButton.bounds.size.width

        // Shadow and Radius for Circle Button
        locationButton.layer.shadowColor = UIColor.black.cgColor
        locationButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        locationButton.layer.masksToBounds = false
        locationButton.layer.shadowRadius = 3.0
        locationButton.layer.shadowOpacity = 0.2

        viewContainer.addSubview(locationButton)
        locationButton.addTarget(self, action: #selector(locationButtonAction)
            , for: .touchUpInside)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: viewContainer)]


    }

}
