//
//  Models.swift
//  BurritoBuddy
//
//  Created by Robert Brennan on 7/8/20.
//  Copyright © 2020 Creatility. All rights reserved.
//

import Foundation
import UIKit


//MARK: - Restaurant Item Struct
struct RestaurantItem
{
    var name:String?
    var image:String?
    var location:String?

    init(name: String, image: String, location: String) {

        self.name = name
        self.image = image
        self.location = location

    }
}
