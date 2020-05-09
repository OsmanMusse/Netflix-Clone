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
    var trailerCustomCell: TrailerCustomView?
    var moreLikeThisCustomCell: MoreLikeThisCustomView?
    var homeScreen: HomeScreen?
    var isBackBtnHidden: Bool?

    var videoCategory: [VideoCategory]?
    var video: VideoData?
    var similarVideos: [VideoData] = []
    


    
    
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
                 episodeHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: episodeHeaderId, for: indexPath) as? EpisodeHeader
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
                let trailerCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: trailerGidCellId, for: indexPath) as? TrailerCustomView
                trailerCustomCell?.videoInformation = video?.videoTrailer?[indexPath.item]
                trailerCustomCell?.videoController = self
                return trailerCustomCell!
                
            default:
                 episodeHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: episodeHeaderId, for: indexPath) as? EpisodeHeader
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
                    moreLikeThisCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: moreLikeThisCellId, for: indexPath) as! MoreLikeThisCustomView
                    moreLikeThisCustomCell?.singleVideoController = self
                    moreLikeThisCustomCell?.videoInformation = similarVideos
                    moreLikeThisCustomCell?.videoCategory = video?.videocategory
                    
                    return moreLikeThisCustomCell!
                    
                default:
                     episodeHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: episodeHeaderId, for: indexPath) as? EpisodeHeader
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
        
        if offsetY < 429.0 {
            singleHeader?.shouldAnimationGoDown = true
        } else {
             singleHeader?.shouldAnimationGoDown = false
        }

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
        } else {
             navigationController?.isNavigationBarHidden = false
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
            trailerCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: trailerGidCellId, for: indexPath) as? TrailerCustomView
            trailerCustomCell?.videoController = self
            trailerCustomCell?.videoInformation =  video?.videoTrailer?[indexPath.item]
            return trailerCustomCell!
        }
        
        if isMoreLikeThisGrid {
            moreLikeThisCustomCell  = collectionView.dequeueReusableCell(withReuseIdentifier: moreLikeThisCellId, for: indexPath) as! MoreLikeThisCustomView
            moreLikeThisCustomCell?.singleVideoController = self
            moreLikeThisCustomCell?.videoInformation = similarVideos
            moreLikeThisCustomCell?.videoCategory = video?.videocategory
            return moreLikeThisCustomCell!
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
    
    func didTapLikeIcon() {
        homeScreen?.getMyListData()
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
