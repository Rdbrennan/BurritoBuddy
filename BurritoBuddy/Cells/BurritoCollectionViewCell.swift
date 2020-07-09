//
//  BurritoCollectionViewCell.swift
//  BurritoBuddy
//
//  Created by Robert Brennan on 7/8/20.
//  Copyright © 2020 Creatility. All rights reserved.
//

import UIKit

class BurritoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!

    var cellIndex:Int = 0

    private lazy var setupOnce: Void = {
        contentView.layer.cornerRadius = 12.0
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        _ = setupOnce
    }

    // MARK: - DATA SETUP

    var model:GooglePlace?{
        didSet{
            guard let model = model else {
                return
            }
            if let restaurantImage = model.photo{
                restaurantImageView.image = restaurantImage
                restaurantNameLabel.textColor = UIColor.white
                restaurantAddressLabel.textColor = UIColor.white
            }
            else{
                restaurantImageView.image = #imageLiteral(resourceName: "AppLaunch")
                restaurantNameLabel.textColor = UIColor.black
                restaurantAddressLabel.textColor = UIColor.black
            }
            restaurantNameLabel.text = model.name
            restaurantAddressLabel.text = model.address

        }
    }
}
