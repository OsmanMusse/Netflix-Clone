//
//  ViewController.swift
//  TableViews
//
//  Created by Mezut on 06/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import SwiftUI

class HomeScreen: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomeScreenRefreshDelegate, SingleVideoHeaderDelegate{
    

    
    let cellId = "cellId"
    let myListCellId = "myListCellId"
    let popularCellId = "popularCellId"
    let previewsCellId = "previewsCellId"
    let RecentlyAddedCellId = "RecentlyAddedCellId"
    let VideoViewCellId = "VideoViewCellId"
    let myListCellID = "myListCellID"
    
    var isAddBtnActive = false
    
    func didRefreshFirebaseDatabase() {
        isAddBtnActive = true
        collectionView.reloadData()
        
    }
    
    
    var navList = [String]()
    
    var HeroImageView = [VideoData]()
    var myListAddedImage = [VideoData]()
    
    var BaseCellID = "BaseCellID"
    var ContinueWatchingCellId =  "ContinueCellId"
    var fakeHeaderCellId = "fakeHeaderCellId"
    var NetflixMainHero = "NetflixMainHero"
    var padding: CGFloat = 8
    var collectionViewPadding: CGFloat = 65
    
    var videoInformation: [VideoCategory] = []
    var myListData: [VideoData] = []
    var continueWatchingData:[VideoData] = []
    
    lazy var seriesBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Series", for: .normal)
        button.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     let filmsBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Films", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var myListBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("My List", for: .normal)
        button.addTarget(self, action: #selector(goToListController), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        navigationController?.hidesBarsOnSwipe = true
        self.tabBarController?.tabBar.barTintColor = .black
        
        SVProgressHUD.dismiss()
        
        setupNavBar()
        collectionViewConfig()
        getMyListData()
        getVideoData()
        setupLayout()
    }
    
  
    
    func getVideoData(){
        Firebase.Database.getVideoCategories { (videoCategory) in
            self.videoInformation = videoCategory
            DispatchQueue.main.async {
              self.collectionView.reloadData()
            }
        }
       
            
    }
    
    
    func getMyListData(){
        Firebase.Database.getMyListData { (videoData) in
            self.myListData = videoData
            self.collectionView.reloadData()
        }

        
    }
    
    func setupNavBar(){
       
        let netflixLogo = UIBarButtonItem(image: #imageLiteral(resourceName: "netflix (1)").withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        netflixLogo.imageInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
    
        let sview = UIStackView(arrangedSubviews: [seriesBtn,filmsBtn,myListBtn])
        sview.axis = .horizontal
        sview.alignment = .center
        sview.spacing = 50
        sview.distribution = .fillEqually
        sview.translatesAutoresizingMaskIntoConstraints = false
        
        let customView = UIBarButtonItem(customView: sview)

        navigationItem.setRightBarButtonItems([customView], animated: false)
        
        
        
        navigationItem.leftBarButtonItem = netflixLogo
        
        
        // Hide the default back button
        navigationItem.hidesBackButton = true
        
        
        
        // Makes the Navigation Bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        

    }
    
    
    
    
    func collectionViewConfig(){
        
        collectionView.register(CustomPreviewsViewCell.self, forCellWithReuseIdentifier: previewsCellId)
        collectionView.register(BaseViewCell.self, forCellWithReuseIdentifier: BaseCellID)
        collectionView.register(WarFilmsCustomCell.self, forCellWithReuseIdentifier: ContinueWatchingCellId)
        collectionView.register(VideoViewCell.self, forCellWithReuseIdentifier: VideoViewCellId)
        collectionView.register(HomeScreenHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NetflixMainHero)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: myListCellID)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: fakeHeaderCellId)
        collectionView.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        
        // Will allow the Hero Header to fill the upper part of the navigation bar
        collectionView.contentInsetAdjustmentBehavior = .never

    }
    
  


    func goToVideoController(video: VideoData, allowScreenTransitionAnimation: Bool, allowCellAnimation: Bool) {
        let layout = StretchyHeaderLayout()
        let singleVideoController = SingleVideoController(collectionViewLayout: layout)
        singleVideoController.modalPresentationStyle = .currentContext
        singleVideoController.video = video
        singleVideoController.homeScreen = self
        singleVideoController.isBackBtnHidden = true
        self.navigationController?.present(singleVideoController, animated: true, completion: nil)
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if myListData.count > 0, section == 0 {
            return  1
        }
        switch section{
        case 1: return videoInformation.count
        case 2: return 1
        default: return 0
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if myListData.count > 0 {
            return 3
        } else {
            return 1
        }
        
    }
    
 
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NetflixMainHero, for: indexPath) as!  HomeScreenHeader

            header.homeScreen = self
            header.delegate = self
           
            return header
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: fakeHeaderCellId, for: indexPath)
        
        return header
    
     
    }
   
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 500)
        }
            return CGSize(width: view.frame.width, height: 0)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 2 {
            return CGSize(width: view.frame.width, height: 350)
        }
          else {
            return CGSize(width: view.frame.width - 2 * padding, height: 190)
        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: collectionViewPadding, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return collectionViewPadding
      }

  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoViewCellId, for: indexPath)
            return cell
        }
                
        if myListData.count > 0, indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseCellID, for: indexPath) as! BaseViewCell
            cell.videoInfo = myListData
            return cell
        }
        
       else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseCellID, for: indexPath) as! BaseViewCell
            if videoInformation.count > 0 {
                cell.videoData = videoInformation[indexPath.item]
            }
            return cell
        }
        
    }
 
    
    func setupLayout(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -125),
        ])
    }
   
    @objc func handleRefresh(){
        collectionView.reloadData()
    }

 
     @objc func goToListController(){
        self.navigationController?.pushViewController(MyListController(), animated: true)
    }

 
   override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        
    }


}

    
    

