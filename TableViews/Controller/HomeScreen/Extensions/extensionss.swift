//
//  extensionss.swift
//  TableViews
//
//  Created by Mezut on 14/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase




extension Firebase.Database {
    
    
    static func getSpecficVideoCategory(catergoryName: CategoryList, completion: @escaping ([VideoData]) -> Void){
        Firebase.Database.database().reference().child("Videocategories").observeSingleEvent(of: .value) { (snapShot) in
            
          guard let arrayCategory = snapShot.value as? [String: Any] else {return}
          var videoArray = [VideoData]()
            
          for cateogry in arrayCategory {
                
            guard let categoryDict = cateogry.value as? [String: Any] else {return}
            guard let categoryName = categoryDict["name"] as? String else {return}
                
            if categoryName == catergoryName.text {
               guard let categoryVideos = categoryDict["videoData"] as? [String:Any] else {return}
                
                for video in categoryVideos {
                 
                    
                 let videoInfo = VideoData()
                 guard let videoDict = video.value as? [String: Any] else {return}
                 guard let videoTitle = videoDict["videoTitle"] as? String else {return}
                 guard let videoURL = videoDict["videoURL"] as? String else {return}
                    
                 videoInfo.videoTitle = videoTitle
                 videoInfo.videoURL = videoURL
                    
                 videoArray.append(videoInfo)

                 
                 // Prevent more then 6 Videos to be added to the list
                 if videoArray.count == 6 {
                   completion(videoArray)
                   return
                }
                    
             }
              
                    
          }
            
        }
            
        }
        
      } // Closing getSpecficVideoCategory Function
    

    static func getVideoCategories(completion: @escaping ([VideoCategory]) -> Void){
        Firebase.Database.database().reference().child("Videocategories").observe(.value) { (snapShot) in
            var videoCategoryArray:[VideoCategory] = []
            var videoDataArray: [VideoData] = []
            guard let categoryDict = snapShot.value as? [String: Any] else {return}
            for videoDict in categoryDict {
                var videoCategoryInfo = VideoCategory()
                guard let videoCategoryDict = videoDict.value as? [String: Any] else {return}
                guard let videoCategoryName = videoCategoryDict["name"] as? String else {return}
                guard let videoDataDict = videoCategoryDict["videoData"] as? [String: Any] else {return}
                if videoDataArray.count > 0 {
                    videoCategoryInfo.name = videoCategoryName
                    videoCategoryInfo.videoData = videoDataArray
                    videoCategoryArray.append(videoCategoryInfo)
                }
           
                videoDataArray = []
                
    
                for video in videoDataDict {
                    var videoData = VideoData()
                    guard let dict = video.value as? [String: Any] else {return}
                    guard let videoTitle = dict["videoTitle"] as? String else {return}
                    guard let videoURL = dict["videoURL"] as? String else {return}
                    videoData.videoTitle = videoTitle
                    videoData.videoURL = videoURL
                    videoDataArray.append(videoData)
                }
                
    
                
                
            }
            
            completion(videoCategoryArray)
        }
    }
    
    static func getActiveUser(completion: @escaping (ProfileModel) -> Void) {
         let userID = Firebase.Auth.auth().currentUser?.uid
         Firebase.Database.database().reference().child("Users").child(userID!).child("Profiles").observeSingleEvent(of: .value) { (snapShot) in
           guard let profilesDict = snapShot.value as? [String:Any] else {return}
                
            for profile in profilesDict {
            let profileKey = profile.key
            guard let profileInfo =  profile.value as? [String: Any] else {return}
            guard let profileName = profileInfo["ProfileName"] as? String else {return}
            guard let activeDict = profileInfo["isActive"] as? Bool else {return}
                
            if activeDict == true {
                let userProfile = ProfileModel(profileName: profileName, profileImage: "")
                userProfile.userIdentifier = profileKey
                completion(userProfile)
            }
                
          }
                      
    
        }
     } // Closing Active User Function
    
    
    static func isVideoResumable(videoTitle: String, completion: @escaping (_ videoResumeTime:CGFloat, _ videoFullTime: CGFloat) -> Void){
        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        getActiveUser { (activeUser) in
            let continueWatchingSection = "Continue Watching For \(activeUser.profileName)"
            guard let profileIdentifier = activeUser.userIdentifier else {return}
            Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").child(profileIdentifier).child(continueWatchingSection).observeSingleEvent(of: .value) { (snapShot) in
        
                
                guard let videoItemArray = snapShot.value as? [String: Any] else {return}
                
                for video in videoItemArray {
                    guard let specificVideo = video.value as? [String: Any] else {return}
                    guard let specificVideoTitle = specificVideo["videoTitle"] as? String else {return}
                    guard let specificVideoTime = specificVideo["videoTime"] as? CGFloat else {return}
                    guard let fullVideoTime = specificVideo["fullVideoSeconds"] as? CGFloat else {return}
                    if videoTitle == specificVideoTitle {
                        completion(specificVideoTime, fullVideoTime)
                        return
                    }
                }
            }
            
        }
       
    } // Closing isVideoResumable Function
    
    static func updateVideoTimeChange(activeUser: ProfileModel, videoTime: CGFloat, updatedProfileKey: String?, videoData: VideoData,fullVideoSeconds: CGFloat){
        let userID = Firebase.Auth.auth().currentUser?.uid
        guard let profileKey = activeUser.userIdentifier else {return}
        let continueWatchingSection = "Continue Watching For \(activeUser.profileName)"
        guard let videoTitle = videoData.videoTitle else {return}
        let randomVideoKey = UUID().uuidString
        let videoInfoDict = ["videoTitle": videoTitle, "videoTime": videoTime,"fullVideoSeconds": fullVideoSeconds] as [String : Any]
        let newDict = [continueWatchingSection: [randomVideoKey: videoInfoDict]]
        
        if updatedProfileKey == nil {
            let dict = [randomVideoKey: videoInfoDict]
            Firebase.Database.database().reference().child("Users").child(userID!).child("Profiles").child(profileKey).child(continueWatchingSection).updateChildValues(dict)
        } else {
            if let dict = ["videoTime": videoTime, "videoTitle": videoTitle, "fullVideoSeconds": fullVideoSeconds] as? [String : Any] {
            Firebase.Database.database().reference().child("Users").child(userID!).child("Profiles").child(profileKey).child(continueWatchingSection).child(updatedProfileKey!).updateChildValues(dict)
            }
        }
        
          
    } // Closing updateVideoTimeChange Function
    
    static func validateVideoTimeChange(activeUser: ProfileModel, videoTime: CGFloat, videoData: VideoData, fullVideoSeconds: CGFloat){
        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        guard let profileKey = activeUser.userIdentifier else {return}
        guard let videoTitle = videoData.videoTitle else {return}
        let continueWatchingSection = "Continue Watching For \(activeUser.profileName)"
        let randomVideoKey = UUID().uuidString
        Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").child(profileKey).child(continueWatchingSection).observeSingleEvent(of: .value) { (snapShot) in
            
            
            // Check the profile has any video to continue to watch
            if let videoDictionary = snapShot.value as? [String: Any] {
                for video in videoDictionary {
                    let videoKey = video.key
                    guard let specificVideo = video.value as? [String:Any] else {return}
                    guard let videoName = specificVideo["videoTitle"] as? String else {return}
                    guard let videoduration = specificVideo["videoTime"] as? CGFloat else {return}
                    if videoTitle == videoName {
                        if videoTime > videoduration {
                            updateVideoTimeChange(activeUser: activeUser, videoTime: videoTime, updatedProfileKey: videoKey, videoData: videoData, fullVideoSeconds: fullVideoSeconds)
                            return
                        } else {
                            return
                        }
                    }
                }
                
                updateVideoTimeChange(activeUser: activeUser, videoTime: videoTime, updatedProfileKey: nil, videoData: videoData, fullVideoSeconds: fullVideoSeconds)
                 return
            }
            
            // Profile has no videos to continue to watch
            Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").child(profileKey).child(continueWatchingSection).updateChildValues([randomVideoKey: ["videoTime": videoTime, "videoTitle": videoTitle, "fullVideoSeconds": fullVideoSeconds]])
            return
        
        }
        
        
    } // Closing ValidateVideoTimeChange
    
    
    static func updateMyListData(videoInfo: VideoData){
        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        Firebase.Database.getActiveUser { (profileModel) in
            guard let userIdentifier = profileModel.userIdentifier else {return}
            guard let videoTitle = videoInfo.videoTitle else {return}
            guard let videoURL = videoInfo.videoURL else {return}
            let randomKey = UUID().uuidString
            let videoDict = ["videoTitle": videoTitle, "videoURL": videoURL, "likes": 1] as [String : Any]
            let dict = [randomKey:videoDict]
            
            Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").child(userIdentifier).child("My List").observeSingleEvent(of: .value) { (snapShot) in

                if let dict = snapShot.value as? [String:Any] {
                    for video in dict {
                        if let videoDictionary = video.value as? [String: Any], videoTitle == videoDictionary["videoTitle"] as? String {
                            Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").child(userIdentifier).child("My List").child(video.key).removeValue()
                            return
                        
                        }
                        
                    }
                    
                }
                
                Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").child(userIdentifier).child("My List").updateChildValues(dict)
            }
            
             
            
        }
        
    }
    static func getMyListData(completion: @escaping ([VideoData]) -> Void) {
        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        Firebase.Database.getActiveUser { (profileModel) in
            guard let userIdentifier = profileModel.userIdentifier else {return}
            Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").child(userIdentifier).child("My List").observe(.value) { (snapShot) in
                var videoDataArray: [VideoData] = []
                guard let videoDict = snapShot.value as? [String:Any] else {return}
                for video in videoDict {
                    var videoInfo = VideoData()
                    guard let videoDictionary = video.value as? [String: Any] else {return}
                    guard let videoTitle = videoDictionary["videoTitle"] as? String else {return}
                    guard let videoURL = videoDictionary["videoURL"] as? String else {return}
                    videoInfo.videoTitle = videoTitle
                    videoInfo.videoURL = videoURL
                    videoInfo.isAddedToMyList = true
                    videoDataArray.append(videoInfo)
                }
                completion(videoDataArray)
            }
        }
    } // Closing getMyListData Function
    
    
    

    static func addToMyList(videoInfo: VideoData){
        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        Firebase.Database.getActiveUser { (profileData) in
            guard let userIdentifier = profileData.userIdentifier else {return}
            guard let videoTitle = videoInfo.videoTitle else {return}
            guard let videoURL = videoInfo.videoURL else {return}
            let randomKey = UUID().uuidString
            let videoInfoDict = ["videoTitle": videoTitle, "videoURL": videoURL]
            let videoDict = [randomKey : videoInfoDict]
            Firebase.Database.database().reference().child("MyList").child(userID).child(userIdentifier).updateChildValues(videoDict)
        }
        
    } // Closing Add To My List Function
    
    static func removeFromMyList(videoInfo: VideoData){
        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        Firebase.Database.getActiveUser { (profileInfo) in
            guard let userIdentifier = profileInfo.userIdentifier else {return}
            guard let videoKey = videoInfo.videoKeyIdentifier else {return}
            Firebase.Database.database().reference().child("MyList").child(userID).child(userIdentifier).child(videoKey).removeValue()
        }
        
    }
    
    
    
    
    
    static func getRandomTrailerVideo(completion: @escaping (VideoData) -> Void){
        guard let userID = Firebase.Auth.auth().currentUser?.uid else {return}
        Firebase.Database.database().reference().child("Videocategories").observeSingleEvent(of: .value) { (snapShot) in
            guard let dict = snapShot.value as? [String: Any] else {return}
            for videoCategory in dict  {
                guard let videoDict = videoCategory.value as? [String: Any] else {return}
                guard let categoryName = videoDict["name"] as? String else {return}
                guard let categoryVideos = videoDict["videoData"] as? [String: Any] else {return}
                if categoryName == "Trending Now" {
                    for videos in categoryVideos {
                        let videoInfo = VideoData()
                        guard let videoTrailerDict = videos.value as? [String:Any] else {return}
                        for videoTrailer in videoTrailerDict {
                            let videoKey = UUID().uuidString
                            guard let videoTrailerArray = videoTrailerDict["videoTrailer"] as? [String: Any] else {return}
                            guard let videoTrailerTitle = videoTrailerArray["trailerTitle"] as? String else {return}
                            guard let videoTrailerURL = videoTrailerArray["videoURL"] as? String else {return}
                            videoInfo.videoTitle = videoTrailerTitle
                            videoInfo.videoURL = videoTrailerURL
                            videoInfo.videoKeyIdentifier = videoKey
                            completion(videoInfo)
                            return
                        }
                    }
                }
            }
        }
    }
    
    
    
    static func getRandomHeroImage(completion: @escaping  (VideoData) -> Void){
        Firebase.Database.database().reference(withPath: ".info/connected") .child("HeroImages").observe(.value) { (snapShot) in
            if snapShot.value as? Bool ?? false {
                 guard let dict = snapShot.value as? [String : Any] else {return}
                 var videoDataArray: [VideoData] = []
                 let videoDataInfo = VideoData()
                 for item in dict {
                         guard let videoInfo = item.value as? [String: Any] else {return}
                         guard let videoTitle = videoInfo["videoTitle"] as? String else {return}
                         guard let videoURL = videoInfo["videoURL"] as? String else {return}
                         videoDataInfo.videoTitle = videoTitle
                         videoDataInfo.videoURL = videoURL
                         videoDataArray.append(videoDataInfo)
                     
                     if videoDataArray.count == 1 {
                         completion(videoDataArray[0])
                     }
                     
                     }

            }
                
            }
            
            
            
        }  // Closing Random Hero Image
    

    
    }
    
  


extension UIView {
    static func manipulateElements(viewsToHide: [UIView], enabledAlpha: Bool?, enableHidden: Bool?) {
        if let viewIsAlpha = enabledAlpha, viewIsAlpha == true{
            for view in viewsToHide {
                view.alpha = 0
            }
        } else {
            for view in viewsToHide {
            view.isHidden = true
        }
        
    }
        
    }
    
    static func manipulateElements(viewsToShow: [UIView], enabledAlpha: Bool?, enableHidden: Bool?){
            if let viewIsAlpha = enabledAlpha, viewIsAlpha == true{
            for view in viewsToShow {
                view.alpha = 1
            }
        } else {
            for view in viewsToShow {
            view.isHidden = false
        }

      }
    }
 
     func formatedCMTime(videoItem: AVPlayerItem, completion: (VideoTime) -> Void) {
        let getVideoSeconds = CMTimeGetSeconds(videoItem.currentTime())
         let videoSeconds = Int(getVideoSeconds) % 60
         let videoMinutes = Int(getVideoSeconds) / 60
      

        let videoInfo = VideoTime(videoMinutes: videoMinutes, videoSeconds: videoSeconds)
         completion(videoInfo)
    }
    

}


 class CustomSlider: UISlider {
     let defaultThumbSpace: Float = 15
     lazy var startingOffset: Float = 0 - defaultThumbSpace
     lazy var endingOffset: Float = 2 * defaultThumbSpace

     override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
         let xTranslation =  startingOffset + (minimumValue + endingOffset) / maximumValue * value
         return super.thumbRect(forBounds: bounds,
                                trackRect: rect.applying(CGAffineTransform(translationX: CGFloat(xTranslation),
                                                                           y: 0)),
                                value: value)
     }
 }



extension NetworkingAlert {
    
    var title: String {
        switch  self {
        case .invalidInternet: return "Error"
        }
    }
    
    var message: String {
        switch self {
        case .invalidInternet: return "Cannot play title. Please try again later.(NSURRL:1009;)"
        }
    }
    
}


