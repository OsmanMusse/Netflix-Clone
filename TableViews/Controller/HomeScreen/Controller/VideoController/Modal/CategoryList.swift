//
//  CategoryList.swift
//  TableViews
//
//  Created by Mezut on 01/05/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

enum CategoryList: CaseIterable {
    case myList
    case Action
    case Series
    case Trending
}

extension CategoryList {
    var text: String {
        switch self  {
        case .myList:  return "myList"
        case .Action:  return "Action TV"
        case .Series:  return "Series"
        case .Trending: return "Trending Now"
        }
    }
    
    static func getCategoryName(videoCategory: String) -> CategoryList? {
       var categoryName: CategoryList?
       for item in CategoryList.allCases {
         if videoCategory == item.text {
           categoryName = item
           return categoryName
         }
      }
             
             return categoryName
    }


        
    }


