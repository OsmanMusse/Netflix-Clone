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
        
        let jimJeffferiesTrailerOne = VideoTrailer()
        jimJeffferiesTrailerOne.videoName = UIImage(named: "Jim-jefferes-trailer")
        jimJeffferiesTrailerOne.videoTitle = "Jim-Jefferes: Season 1(Trailer)"
        
        let jimJeffferiesFilm = VideoData()
        jimJeffferiesFilm.videoTrailer = [jimJeffferiesTrailerOne]
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
        
        let filmCatergory = VideoCategory()
        filmCatergory.name = "Films & TV"
        
        
        var filmVideos = [VideoData]()
        
        let endOfTheWorld = VideoData()
        endOfTheWorld.videoImage = UIImage(named: "the-end-of-the-world")
        endOfTheWorld.videoName = "The End Of The Fi***ng World"
        filmVideos.append(endOfTheWorld)
        
        
        let sexEducation = VideoData()
        sexEducation.videoImage = UIImage(named: "sex-education-poster")
        sexEducation.videoName = "Sex Education"
        filmVideos.append(sexEducation)
        
        let disenchantment = VideoData()
        disenchantment.videoImage = UIImage(named: "Disenchantment-netflix-poster")
        disenchantment.videoName = "Disenchantment"
        filmVideos.append(disenchantment)

        let theEndOfTheWorldCult = VideoData()
        theEndOfTheWorldCult.videoImage = UIImage(named: "the-end-of-the-world-cult-poster")
        theEndOfTheWorldCult.videoName = "The End Of The World Cult"
        filmVideos.append(theEndOfTheWorldCult)
        
        let danganrnpa3 = VideoData()
        danganrnpa3.videoImage = UIImage(named: "danganrnpa-3-poster")
        danganrnpa3.videoName = "Danganrnpa3"
        filmVideos.append(danganrnpa3)
        
        let piratesOfTheCaribbean = VideoData()
        piratesOfTheCaribbean.videoImage = UIImage(named: "Pirates-of-he-Caribbean-Poster")
        piratesOfTheCaribbean.videoName = "Pirates Of The Caribbean The End World"
        filmVideos.append(piratesOfTheCaribbean)
        
        let kissingBooth = VideoData()
        kissingBooth.videoImage = UIImage(named: "The-kissing-booth-poster")
        kissingBooth.videoName = "The Kissing Booth"
        filmVideos.append(kissingBooth)
        
        let blackMirror = VideoData()
        blackMirror.videoImage = UIImage(named: "black-mirror-poster")
        blackMirror.videoName = "black-mirror-poster"
        
        filmVideos.append(blackMirror)
        
        let Ozark = VideoData()
        Ozark.videoImage = UIImage(named: "Ozark-netflix-poster")
        Ozark.videoName = "Ozark"
        filmVideos.append(Ozark)

        
        filmCatergory.videoData = filmVideos
     
        return [myListCategory, filmCatergory]
        
    }
}

class VideoData {
    var videoImage: UIImage?
    var imageTitle: UIImage?
    var videoName: String?
    var imageBorderColor: UIColor?
    var videoTrailer: [VideoTrailer]?
    
    var cgColor: CGColor? {
        guard let videoBorderColor = imageBorderColor else {return nil}
        return videoBorderColor.cgColor
    }
}


class VideoTrailer {
    var videoName: UIImage?
    var videoTitle: String?
}
