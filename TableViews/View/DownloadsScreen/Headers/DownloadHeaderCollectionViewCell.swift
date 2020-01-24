//
//  DownloadHeaderCollectionViewCell.swift
//  TableViews
//
//  Created by Mezut on 17/01/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class DownloadHeader: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        setupLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout(){
        
    }
    
}
