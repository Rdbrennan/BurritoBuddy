//
//  BurritoViewController + UICollectionViewDelegate.swift
//  BurritoBuddy
//
//  Created by Robert Brennan on 7/8/20.
//  Copyright © 2020 Creatility. All rights reserved.
//

import Foundation
import UIKit

// MARK: UICollectionViewDelegates

extension BurritoBuddyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.burritoRestaurants?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BurritoCell", for: indexPath as IndexPath) as! BurritoCollectionViewCell

        if let restaurants =  burritoRestaurants {
            if indexPath.row >= restaurants.count{
                return cell
            }
            cell.model = restaurants[indexPath.row]
        }
        cell.cellIndex = indexPath.row

        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - Constants.cellSpacing)
        return .init(width: width, height: width/2)
    }
}
