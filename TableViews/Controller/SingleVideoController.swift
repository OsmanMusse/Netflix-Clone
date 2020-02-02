//
//  SingleVideoController.swift
//  TableViews
//
//  Created by Mezut on 08/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import Hero
import Firebase


class SingleVideoController: UICollectionViewController, UICollectionViewDelegateFlowLayout, SingleVideoHeaderDelegate{
    
    
    let headerCellId = "headerCellId"
    let CustomVideoCellId = "cellId"
    let videoOptionCellId = "videoOptionCellId"
    let episodeHeaderId = "episodeHeaderId"
    var trailerGidCellId = "trailerGidCellId"
    
    let padding: CGFloat = 5
    
    var isEpisodeGrid: Bool = true
    var isTrailerGrid: Bool = false
    var isMoreLikeThisGrid: Bool = false

    var videoCategory: [VideoCategory]?
    var video: VideoData?
    var imageUrls = [VideoData]()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hero.isEnabled = true
        
        // Setting up the data source of the screen
        videoCategory = VideoCategory.getVideoCategory()
        
        getFirebaseDatabase()
        
        collectionView.backgroundColor = Colors.mainblackColor
        collectionView.register(SingleVideoHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        collectionView.register(EpisodeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: episodeHeaderId)
        collectionView.register(VideoOptionCell.self, forCellWithReuseIdentifier: videoOptionCellId)
        collectionView.register(TrailerCustomView.self, forCellWithReuseIdentifier: trailerGidCellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "RANDOM")
        collectionView.contentInsetAdjustmentBehavior = .never
        
        guard  let videoName = video?.videoName else {return}
        
        // Removes the unwanted translucent background color from the navigation bar
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor =  Colors.mainblackColor
        navigationItem.title = videoName
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        

     
        if let layout = collectionViewLayout as? StretchyHeaderLayout {
            
            layout.minimumLineSpacing = 2
            layout.sectionHeadersPinToVisibleBounds = false
            
        }
    }
    
    func getFirebaseDatabase(){
        
        
        let firebaseDatabase = Database.database().reference()
        firebaseDatabase.observeSingleEvent(of: .value) { (snapShot) in
            guard let dictionary = snapShot.value as? [String: [Dictionary<String,AnyObject>]] else {return }
            guard let firstItem = dictionary["Videocategories"] else {return}
            guard let videoSection = firstItem[1]["videoData"] else {return}
            guard let videoInformation = videoSection as? [Dictionary<String, AnyObject>] else {return}
            
            
            
            for item in videoInformation {
                
                guard let videoUrl = item["videoUrl"] as? String else {return}
                
                let singleVideo = VideoData()
                singleVideo.videoName = videoUrl
                self.imageUrls.append(singleVideo)
                
                
                
            }
            
            
            self.collectionView.reloadData()
            
            
            
            
        }
        
    }
    
    
   
    
    var singleHeader: SingleVideoHeader?
    var episodeHeader: EpisodeHeader?
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:  return CGSize(width: self.view.frame.width, height: 660)
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
                singleHeader?.hero.modifiers = [.fade, .translate(CGPoint(x: 0, y: 100))]
                print("MASCUUD HELLO WORLD == \(indexPath.item)")
//                singleHeader?.videoInformation = imageUrls[indexPath.item]
                singleHeader?.delegate = self
                return singleHeader!
            case 1:
                episodeHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: episodeHeaderId, for: indexPath) as? EpisodeHeader
                episodeHeader?.singleVideoReference = self
                
                return episodeHeader!
                
            default:
                let header2 = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: episodeHeaderId, for: indexPath) as? EpisodeHeader
                episodeHeader?.backgroundColor = .purple
                episodeHeader?.hero.modifiers = [.fade, .translate(CGPoint(x: 0, y: 100))]
                episodeHeader?.singleVideoReference = self
                return episodeHeader!
                
            }
        }
        
        if isTrailerGrid {
            switch (indexPath.section) {
            case 0:
                singleHeader =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId, for: indexPath) as? SingleVideoHeader
                singleHeader?.singleVideoController = self
                singleHeader?.videoInformation = imageUrls[indexPath.item]
                return singleHeader!
            case 1:
                let trailerHeader = collectionView.dequeueReusableCell(withReuseIdentifier: trailerGidCellId, for: indexPath) as? TrailerCustomView
                return trailerHeader!
                
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
            singleHeader?.videoInformation = imageUrls[indexPath.item]
            return singleHeader!
        }
       
        
        
    }
    
    
   
  
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let calculatedNumber = abs(offsetY) / 100
        let newNumber = 1.0 - calculatedNumber
        var osman = CGFloat(0.0)
        
        singleHeader?.blackCancelView.alpha = newNumber
        
        // Dimiss the controller if dragged down
        if offsetY <= -220.00 {
            navigationController?.dismiss(animated: true, completion: nil)
        }
        
        if offsetY >= 300 {
            navigationController?.isNavigationBarHidden = false
        } else {
             navigationController?.isNavigationBarHidden = true
        }
    
            if let layout = collectionViewLayout as? StretchyHeaderLayout {
                let isEpiosdeColorWhite = singleHeader?.episodeBtn.titleLabel?.textColor == UIColor.white
                 if(offsetY > 700 && isEpiosdeColorWhite == true) {
                layout.sectionHeadersPinToVisibleBounds = true
                    episodeHeader?.seasonLabel.alpha = 0.0
                 } else{
                    layout.sectionHeadersPinToVisibleBounds = false
                     episodeHeader?.seasonLabel.alpha = 1.0
                }
                
                guard let layoutInfo = layout.layoutAttributesForElements(in: collectionView.frame) else {return}
                
                layoutInfo.forEach({ (attributes) in
                    if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 1  && attributes.indexPath.item == 0 {
                        if attributes.frame.origin.y > 700 {
                             navigationItem.title = "Season 1"
                        } else {
                            guard let videoName = video?.videoName else {return}
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
            case 1:  return CGSize(width: view.frame.width - 2 * padding, height: 250)
            default:  return CGSize(width: view.frame.width - 2 * padding, height: 250)
            }
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
            case 0:  return 3
            case 1: return imageUrls.count
            default: return 6
            }
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
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isEpisodeGrid {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoOptionCellId, for: indexPath)
            return cell
        }
        
        if isTrailerGrid {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trailerGidCellId, for: indexPath) as? TrailerCustomView
            cell?.videoCategory = videoCategory?[0]
            return cell!
        }
        
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoOptionCellId, for: indexPath)
            
            return cell
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
        isEpisodeGrid = false
        isMoreLikeThisGrid = false
    }
    
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    

    
    func goToHomeScreen(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}




