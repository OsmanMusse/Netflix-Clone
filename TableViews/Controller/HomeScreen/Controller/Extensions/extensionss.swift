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
    

    static func getVideoCategories(completion: @escaping (VideoCategory) -> Void){
        
        Firebase.Database.database().reference().child("Videocategories").observe(.value) { (snapShot) in
            
            guard let arrayCategory = snapShot.value as? [String: Any] else {return}
             let videoCategory = VideoCategory()
             var videoArray = [VideoData]()
             var videoTrailerArray = [VideoTrailer]()


            
            for item in arrayCategory {
               guard let dictionary = item.value as? [String: Any] else {return}
               guard let categoryTitle = dictionary["name"] as? String else {return}
            
               videoCategory.videoData?.removeAll()
            
               videoCategory.name = categoryTitle
            
               guard let categoryVideos = dictionary["videoData"] as? [String:Any] else {return}

               videoArray = []
               videoTrailerArray = []
            
                for video in categoryVideos {
                    var videoInfo = VideoData()
                    var videoTrailer = VideoTrailer()
                    guard let videoDict = video.value as? [String:Any] else {return}
                    
                    if let videoTitle = videoDict["videoTitle"] as? String {
                        videoInfo.videoTitle = videoTitle
                        videoInfo.videocategory = categoryTitle
                    }
                    
                    guard let videoURL = videoDict["videoURL"] as? String else {return}
                    videoInfo.videoURL = videoURL
                    
                    
                    videoTrailerArray.removeAll()
                    
                    if let videoTrailerDict = videoDict["videoTrailer"] as? [String: Any], let trailerTitle = videoTrailerDict["trailerTitle"] as? String,let  videoURL = videoTrailerDict["videoURL"] as? String {
                        videoTrailer.videoTitle = trailerTitle
                        videoTrailer.videoURL = videoURL
                    }
                    
                    videoTrailerArray.append(videoTrailer)
                    videoInfo.videoTrailer = videoTrailerArray
                    
                    videoArray.append(videoInfo)

                    videoCategory.videoData = videoArray
                    
                }
                
                
                completion(videoCategory)
                
            }
          

        }
    
    } // Closing Get Video Category Function
    
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
        
        
        
    }
    

    
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


