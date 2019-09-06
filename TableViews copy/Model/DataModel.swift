//
//  DataModel.swift
//  TableViews
//
//  Created by Mezut on 27/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit



class VideoCategory {
    var name: String?
    var videoData: [VideoData]?
    
    
    static func getVideoCategory() -> [VideoCategory] {
        let myListCategory = VideoCategory()
        myListCategory.name = "My List"
        
        var videos = [VideoData]()
        
        let jimJeffferiesFilm = VideoData()
        jimJeffferiesFilm.videoImage = UIImage(named: "Jim-Jeffers-Poster")
        jimJeffferiesFilm.videoName = "jimJeffferiesFilm"
        videos.append(jimJeffferiesFilm)
        
        let thisIsMeNowFilm = VideoData()
        thisIsMeNowFilm.videoImage =  UIImage(named: "Jim-Jeffereis-this-is-me-poster")
        thisIsMeNowFilm.videoName = "thisIsMeNowFilm"
        videos.append(thisIsMeNowFilm)
        
        let billBuss = VideoData()
        billBuss.videoImage = UIImage(named: "Bill-Buss-Poster")
        billBuss.videoName = "billBuss"
        videos.append(billBuss)
        
        
        let billBurr = VideoData()
        billBurr.videoImage = UIImage(named: "Bill-Burr-Poster")
        billBurr.videoName = "BillBurrr"
        videos.append(billBurr)
        
        myListCategory.videoData = videos
        
        
//        let popularOnNetflixCategory = VideoCategory()
//        popularOnNetflixCategory.name = "Popular on Netflix"
//
//        var popularOnNetflixVideos = [VideoData]()
//
//        let jimJeffferiesFilm2 = VideoData()
//        jimJeffferiesFilm2.videoImage = UIImage(named: "Jim-Jeffers-Poster")
//        popularOnNetflixVideos.append(jimJeffferiesFilm2)
//
//        let thisIsMeNowFilm2 = VideoData()
//        thisIsMeNowFilm2.videoImage =  UIImage(named: "Jim-Jeffereis-this-is-me-poster")
//        popularOnNetflixVideos.append(thisIsMeNowFilm2)
//
//        let billBuss2 = VideoData()
//        billBuss2.videoImage = UIImage(named: "Bill-Buss-Poster")
//        popularOnNetflixVideos.append(billBuss2)
//
//        popularOnNetflixCategory.videoData = popularOnNetflixVideos
        
        
        
        return [myListCategory]
        
    }
}

class VideoData {
    var videoImage: UIImage?
    var imageTitle: UIImage?
    var videoName: String?
    var imageBorderColor: UIColor?
    
    var cgColor: CGColor? {
        guard let videoBorderColor = imageBorderColor else {return nil}
        return videoBorderColor.cgColor
    }
}
