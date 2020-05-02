//
//  ImagePicker.swift
//  TableViews
//
//  Created by Mezut on 01/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit


struct ImagePicker {
    var categoryTitle: String
    var pickerImages: [String : String]

    init(dictionary:[String : [String : String]]) {
        
         let catergoryLabel = dictionary.keys
         var categoryText: String  = ""
         for title in catergoryLabel {
         categoryText = title
        }
        
        self.categoryTitle = categoryText
        
        let catergoryImages = dictionary.values
        
        var categoryFake: [String : String] = [:]
        for image in catergoryImages {
            categoryFake = image
    }
        
        self.pickerImages = categoryFake
        
        
}

}
