//
//  MyListViewCell.swift
//  TableViews
//
//  Created by Mezut on 30/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

import Firebase


class MyListViewCell: BaseListViewCell<CustomListCell> {
    
       var imageUrls = [VideoData]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CustomListCell: BaseCollectionViewCell {
    
}

