//
//  ViewController.swift
//  TableViews
//
//  Created by Mezut on 06/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import Firebase

class HomeScreen: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomeScreenRefreshDelegate{
    
    
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
    
 

    
    
    let cellId = "cellId"
    let myListCellId = "myListCellId"
    let popularCellId = "popularCellId"
    let previewsCellId = "previewsCellId"
    let RecentlyAddedCellId = "RecentlyAddedCellId"
    let VideoViewCellId = "VideoViewCellId"
    
    override func viewDidLoad() {


        view.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        navigationController?.hidesBarsOnSwipe = true
        self.tabBarController?.tabBar.barTintColor = .black
        self.tabBarController?.tabBar.isTranslucent = false
        
        setupNavBar()
        collectionViewConfig()
        
        

        
        
        


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
        collectionView.register(ContinueWatchingCell.self, forCellWithReuseIdentifier: ContinueWatchingCellId)
        collectionView.register(VideoViewCell.self, forCellWithReuseIdentifier: VideoViewCellId)
        collectionView.register(HomeScreenHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NetflixMainHero)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: fakeHeaderCellId)
        collectionView.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        
        // Will allow the Hero Header to fill the upper part of the navigation bar
        collectionView.contentInsetAdjustmentBehavior = .never
        
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 35, left: 0, bottom: padding, right: 0)
        }
    }

    
    
    

    func goToVideoController(video: VideoData, allowScreenTransitionAnimation: Bool, allowCellAnimation: Bool) {
        let layout = StretchyHeaderLayout()
        let singleVideoController = SingleVideoController(collectionViewLayout: layout)
        singleVideoController.hero.isEnabled = allowScreenTransitionAnimation
        singleVideoController.animateCell = allowCellAnimation
         singleVideoController.video = video

        self.present(singleVideoController, animated: true, completion: nil)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
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
        
        switch indexPath.section {
           case 0: return CGSize(width: view.frame.width - 2 * padding, height: 135)
           case 1:  return CGSize(width: view.frame.width, height: 200)
           case 3: return CGSize(width: view.frame.width - 2 * padding, height: 300)
           default:  return CGSize(width: view.frame.width - 2 * padding, height: 150)
        }

    }
    
    
  
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewsCellId, for: indexPath) as! CustomPreviewsViewCell
                 return cell
            
        case 1: let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ContinueWatchingCellId, for: indexPath) as! ContinueWatchingCell
        cell.homeScreen = self
            return cell
            
        case 3:  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoViewCellId, for: indexPath) as! VideoViewCell
        return cell
            
            
        default: let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseCellID, for: indexPath) as! BaseViewCell
        
        if isAddBtnActive == true {
            cell.getFirebaseDatabase()
        }
        
        
       cell.homeScreen = self
    
        return cell
        }
     
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
    
    
   
    
    
