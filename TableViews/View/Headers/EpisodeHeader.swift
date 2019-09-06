//
//  EpisodeHeader.swift
//  TableViews
//
//  Created by Mezut on 22/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class EpisodeHeader: UICollectionViewCell {
    
    var singleVideoReference: SingleVideoController?
    
    
    let padding: CGFloat = 8
    
    let seasonLabel:UILabel = {
        let label = UILabel()
        label.text = "Season 1"
        label.textColor = Colors.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout(){
        addSubview(seasonLabel)
        
        
        NSLayoutConstraint.activate([
            
            seasonLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            seasonLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            
            
            ])
    }
    
    
    
    
}



class CustomVideoCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


