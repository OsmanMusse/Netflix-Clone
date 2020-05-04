//
//  SingleVideoController.swift
//  TableViews
//
//  Created by Mezut on 08/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import SwiftUI
import Hero
import Firebase


class SingleVideoController: UICollectionViewController, UICollectionViewDelegateFlowLayout, SingleVideoHeaderDelegate{
    
    
    private let headerCellId = "headerCellId"
    private let CustomVideoCellId = "cellId"
    private let videoOptionCellId = "videoOptionCellId"
    private let episodeHeaderId = "episodeHeaderId"
    private let trailerGidCellId = "trailerGidCellId"
    private let moreLikeThisCellId = "moreLikeThisCellId"
    
    let padding: CGFloat = 5
    
    
    var isEpisodeGrid: Bool = true
    var isTrailerGrid: Bool = false
    var isMoreLikeThisGrid: Bool = false
    
    var singleHeader: SingleVideoHeader?
    var episodeHeader: EpisodeHeader?
    var videoOptionCell: VideoOptionCell?
    var isBackBtnHidden: Bool?

    var videoCategory: [VideoCategory]?
    var video: VideoData?
    var similarVideos: [VideoData] = []
    
    lazy var overlayView: UIView = {
       let view = UIView()
        view.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleRating))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = UIColor.red.withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    
    
    var animateCell: Bool?{
        didSet{
            
        }
    }
    
    
    override func viewDidLoad() {
        transitioningDelegate = self
        super.viewDidLoad()
        // Setting up the data source of the screen
        setupNavigation()
        setupCollectionView()
        fetchSimilarVideos()
        setupLayout()
    }
    
    
    func setupNavigation(){
        if let videoTitle = video?.videoTitle {
          navigationItem.title = videoTitle
        }
        
      // Removes the unwanted translucent background color from the navigation bar
      navigationController?.isNavigationBarHidden = false
      navigationController?.navigationBar.isTranslucent = false
      navigationController?.navigationBar.barTintColor =  Colors.mainblackColor
      navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = Colors.mainblackColor
        collectionView.register(SingleVideoHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        collectionView.register(EpisodeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: episodeHeaderId)
        collectionView.register(VideoOptionCell.self, forCellWithReuseIdentifier: videoOptionCellId)
        collectionView.register(TrailerCustomView.self, forCellWithReuseIdentifier: trailerGidCellId)
        collectionView.register(MoreLikeThisCustomView.self, forCellWithReuseIdentifier: moreLikeThisCellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "RANDOM")
        collectionView.contentInsetAdjustmentBehavior = .never
        
        if let layout = collectionViewLayout as? StretchyHeaderLayout {
            layout.minimumLineSpacing = 2
            layout.sectionHeadersPinToVisibleBounds = false
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:  return CGSize(width: self.view.frame.width, height: 700)
        case 1:  return CGSize(width: self.view.frame.width, height: 70)
        default:
             return CGSize(width: self.view.frame.width, height: 700)
        }
     
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        if isEpisodeGrid {
            switch (indexPath.section) {
            case 0:
                singleHeader =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId, for: indexPath) as? SingleVideoHeader
                singleHeader?.singleVideoController = self
                singleHeader?.videoInformation = video
                singleHeader?.backBtnState = isBackBtnHidden
                singleHeader?.delegate = self
                return singleHeader!
            case 1:
                episodeHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: episodeHeaderId, for: indexPath) as? EpisodeHeader
                episodeHeader?.singleVideoReference = self
                return episodeHeader!
                
            default:
                let header2 = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: episodeHeaderId, for: indexPath) as? EpisodeHeader
                episodeHeader?.backgroundColor = .purple
                episodeHeader?.singleVideoReference = self
                return episodeHeader!
                
            }
        }
        
        if isTrailerGrid {
            switch (indexPath.section) {
            case 0:
                singleHeader =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId, for: indexPath) as? SingleVideoHeader
                singleHeader?.singleVideoController = self
                singleHeader?.videoInformation = video
                singleHeader?.backBtnState = isBackBtnHidden
                return singleHeader!
            case 1:
                let trailerHeader = collectionView.dequeueReusableCell(withReuseIdentifier: trailerGidCellId, for: indexPath) as? TrailerCustomView
                trailerHeader?.videoInformation = video?.videoTrailer?[indexPath.item]
                return trailerHeader!
                
            default:
                let header2 = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: episodeHeaderId, for: indexPath) as? EpisodeHeader
                episodeHeader?.backgroundColor = .purple
                episodeHeader?.singleVideoReference = self
                return episodeHeader!
                
            }
        }
            
            if isMoreLikeThisGrid {
                switch (indexPath.section) {
                case 0:
                    singleHeader =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId, for: indexPath) as? SingleVideoHeader
                    singleHeader?.singleVideoController = self
                    singleHeader?.videoInformation = video
                    singleHeader?.backBtnState = isBackBtnHidden
                    return singleHeader!
                case 1:
                    let MoreHeader = collectionView.dequeueReusableCell(withReuseIdentifier: moreLikeThisCellId, for: indexPath) as! MoreLikeThisCustomView
                    MoreHeader.singleVideoController = self
                    MoreHeader.videoInformation = similarVideos
                    MoreHeader.videoCategory = video?.videocategory
                    
                    return MoreHeader
                    
                default:
                    let header2 = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: episodeHeaderId, for: indexPath) as? EpisodeHeader
                    episodeHeader?.backgroundColor = .purple
                    episodeHeader?.singleVideoReference = self
                    return episodeHeader!
                    
                }
            }
        
                
        else {
            singleHeader =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId, for: indexPath) as? SingleVideoHeader
            singleHeader?.singleVideoController = self
            singleHeader?.videoInformation = video
            singleHeader?.backBtnState = isBackBtnHidden
            return singleHeader!
        }
       
        
        
    }
    
    
    func enableScrolling(){
        self.collectionView.isScrollEnabled = true
    }
    func disableScrolling(){
        self.collectionView.isScrollEnabled = false
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let calculatedNumber = abs(offsetY) / 100
        let newNumber = 1.0 - calculatedNumber

        if offsetY < -30.0 {
            singleHeader?.blackCancelView.alpha = newNumber
            singleHeader?.goBackView.alpha = newNumber
        }
    
    
        // Dimiss the controller if dragged down
        if offsetY <= -140.0 {
            let layout = UICollectionViewFlowLayout()
            self.navigationController?.popViewController(animated: true)
        }
        
        if offsetY >= 300 {
//            navigationController?.isNavigationBarHidden = true
        } else {
             navigationController?.isNavigationBarHidden = false
        }
    
            if let layout = collectionViewLayout as? StretchyHeaderLayout {
                let isEpiosdeColorWhite = singleHeader?.episodeBtn.titleLabel?.textColor == UIColor.white
                 if(offsetY > 710 && isEpiosdeColorWhite == true) {
                layout.sectionHeadersPinToVisibleBounds = true
                    episodeHeader?.seasonLabel.alpha = 0.0
                 } else{
                    layout.sectionHeadersPinToVisibleBounds = false
                     episodeHeader?.seasonLabel.alpha = 1.0
                }
                
                guard let layoutInfo = layout.layoutAttributesForElements(in: collectionView.frame) else {return}
                
                layoutInfo.forEach({ (attributes) in
                    if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 1  && attributes.indexPath.item == 0 {
                        if attributes.frame.origin.y > 710 {
                             navigationItem.title = "Season 1"
                        } else {
                            guard let videoName = video?.videoTitle else {return}
                          navigationItem.title = videoName
                        }
                    }
                })

                
         
        }
  
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isEpisodeGrid {
            if indexPath.section == 0 {
                return CGSize(width: view.frame.width - 2 * padding, height: 235)
            }
            if indexPath.section == 1 {
                return CGSize(width: view.frame.width - 2 * padding, height: 235)
            } else {
                return CGSize(width: view.frame.width - 2 * padding, height: 50)
            }

        }
            
        if isTrailerGrid == true {
            switch indexPath.section {
            case 1:  return CGSize(width: view.frame.width - 2 * padding, height: 400)
            default:  return CGSize(width: view.frame.width - 2 * padding, height: 400)
            }
        }
            
        if isMoreLikeThisGrid == true {
            return CGSize(width: view.frame.width - 3 * padding, height: 550)
        }
        
        else {
            return CGSize(width: view.frame.width - 2 * padding, height: 50)
        }

        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isEpisodeGrid{
            switch section {
            case 0:  return 0
            case 1: return 20
            default: return 20
            }

        }
        
        if isTrailerGrid {
          switch section {
           case 0:
            if let videoTrailerCount = video?.videoTrailer?.count {
           return videoTrailerCount
        }
            case 1: return 1
            default: return 6
            }
        }
        
        if isMoreLikeThisGrid {
            return 1
        }
        
        else {
            return 1
        }
        

       
    }
    

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if isEpisodeGrid {
               return 2
        }
        
        if isTrailerGrid {
            return 1
        }
        
        if isMoreLikeThisGrid {
            return 1
        }
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isEpisodeGrid {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoOptionCellId, for: indexPath) as! VideoOptionCell
            cell.singleVideoController = self
            return cell
        }
        
        if isTrailerGrid {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trailerGidCellId, for: indexPath) as? TrailerCustomView
            cell?.videoController = self
            cell?.videoInformation =  video?.videoTrailer?[indexPath.item]
            return cell!
        }
        
        if isMoreLikeThisGrid {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moreLikeThisCellId, for: indexPath) as! MoreLikeThisCustomView
            cell.singleVideoController = self
            cell.videoInformation = similarVideos
            cell.videoCategory = video?.videocategory
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoOptionCellId, for: indexPath) as! VideoOptionCell
            cell.singleVideoController = self
            return cell
        }
       
        
    }
    
    
     func goToVideoController(video: VideoData) {
        let layout = StretchyHeaderLayout()
        let singleVideoController = SingleVideoController(collectionViewLayout: layout)
        singleVideoController.modalPresentationStyle = .overCurrentContext
        singleVideoController.transitioningDelegate = self
        singleVideoController.definesPresentationContext = true
        singleVideoController.video = video
        self.present(singleVideoController, animated: true, completion: nil)
    }
    
    
    func fetchSimilarVideos() {
        if let videoCategory = video?.videocategory, let categoryToFetch = CategoryList.getCategoryName(videoCategory: videoCategory) {
            Firebase.Database.getSpecficVideoCategory(catergoryName: categoryToFetch) { (videoData) in
                self.similarVideos = videoData
            }
        }
    }

    
    // Delegate Methods for the Single Video Header
    
    
    func isEpisodeLayout() {

        self.isEpisodeGrid = true
        UIView.transition(with: collectionView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.collectionView.reloadData()
        }, completion: nil)
        

    }
    
    func isTrailerLayout() {
        isTrailerGrid = true
        isEpisodeGrid = false
        isMoreLikeThisGrid = false

        UIView.transition(with: collectionView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.collectionView.reloadData()
        }, completion: nil)
        
        
    }
    
    func isMoreLikeThisLayout() {
        isMoreLikeThisGrid = true
        isTrailerGrid = false
        isEpisodeGrid = false
        
        UIView.transition(with: collectionView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.collectionView.reloadData()
        }, completion: nil)
        
    }
    
    @objc func handleRating(){
        singleHeader?.handleExitRating(notifcation: nil)
    }
    
    func setupLayout(){
        self.view.addSubview(overlayView)
        print(videoOptionCell?.frame)
            NSLayoutConstraint.activate([
            
                overlayView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                overlayView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                overlayView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 0),
                
            ])
    }
    
    func goToHomeScreen(){
           self.dismiss(animated: true, completion: nil)
       }
   
    func goToSharingController(){
        let shareScreen = ShareScreen()
        shareScreen.singleVideoController = self
        shareScreen.modalPresentationStyle = .overFullScreen
        self.present(shareScreen, animated: false, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
}


extension SingleVideoController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return VideoAnimationController(animationDuration: 0.3, animationType: .present)
        
    }
 
}
