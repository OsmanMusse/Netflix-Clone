//
//  CollectionRandomCell.swift
//  TableViews
//
//  Created by Mezut on 19/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class CollectionRandomCell: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "RandomText"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
