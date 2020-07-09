//
//  ViewController.swift
//  BurritoBuddy
//
//  Created by Robert Brennan on 7/6/20.
//  Copyright © 2020 Creatility. All rights reserved.
//

import UIKit
import MBProgressHUD
import ViewAnimator
import Foundation
import CoreLocation

class BurritoBuddyViewController: UIViewController {

    // MARK: - Variables & Outlets
    @IBOutlet weak var burritoCollectionView: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var reloadTableButton: UIButton!

    let cityLabel = UILabel()
    fileprivate var collectionViewRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(animateCollectionCells), for: .valueChanged)
        return refreshControl
    }()

    var locationManager = CLLocationManager()
    public var searchedTypes = ["restaurant"]
    public var keyword = "burrito"
    public let dataProvider = GoogleDataProvider()
    public let searchRadius: Double = 3000


    var userLocation: CLLocationCoordinate2D?

    let locationButton = UIButton(type: .system)
    var burritoRestaurants: [GooglePlace]?


    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        askLocationPermissions()
        configureCollectionView()
        setupNavigationBarItems()
        observeCollectionview()
    }
}

extension BurritoBuddyViewController{

    // MARK: - Collection View Setup

    private func configureCollectionView() {
        errorView.isHidden = true
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.cellSpacing
        layout.minimumInteritemSpacing = Constants.cellSpacing
        reloadTableButton.addTarget(self, action: #selector(errorButtonAction), for: .touchUpInside)
        burritoCollectionView.setCollectionViewLayout(layout, animated: false)
        collectionViewRefreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        self.burritoCollectionView.dataSource = self
        self.burritoCollectionView.delegate = self
        self.burritoCollectionView.backgroundColor = .white
        self.burritoCollectionView.showsVerticalScrollIndicator = false
        self.burritoCollectionView.layer.borderColor = UIColor.clear.cgColor
        self.burritoCollectionView.refreshControl = collectionViewRefreshControl
        self.burritoCollectionView.register(UINib.init(nibName: "BurritoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BurritoCell")
        burritoCollectionView.contentInset = UIEdgeInsets(top:0, left: 10, bottom: 10, right: 10)
    }

    func observeCollectionview(){
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(reloadCollectionView),
                         name: NSNotification.Name(rawValue: "ReloadData"),
                         object: nil)
    }

    // MARK: - ACTIONS

    @objc private func animateCollectionCells(){
        if let userLocation = self.userLocation{
            self.fetchNearbyBurritoPlaces(coordinate: userLocation){ [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    self.collectionViewRefreshControl.endRefreshing()
                    let cells = self.burritoCollectionView.orderedVisibleCells
                    let fromAnimation = AnimationType.from(direction: .bottom, offset: 30.0)
                    _ = AnimationType.zoom(scale: 0.2)
                    UIView.animate(views: cells, animations: [fromAnimation], duration: 2.5)
                }
            }
        }
    }

    @objc private func errorButtonAction(){
        self.fetchNearbyBurritoPlaces(coordinate: self.userLocation!){ [weak self] in
        }
    }
    @objc func reloadCollectionView(){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.burritoCollectionView.reloadData()
        }
    }

    @objc func locationButtonAction(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                sendToSettings(shouldSendToSettings: true)
            case .authorizedAlways, .authorizedWhenInUse:
                sendToSettings(shouldSendToSettings: false)
            @unknown default:
                fatalError()
            }
        } else {
            print("Location services are not enabled")
        }
    }
}
