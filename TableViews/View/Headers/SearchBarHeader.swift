//
//  SearchBarHeader.swift
//  TableViews
//
//  Created by Mezut on 31/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class SearchBarHeader: UICollectionViewCell {
    
    let sectionTitle: UILabel = {
       let label = UILabel()
        label.text = "Films & TV"
        label.font = UIFont(name: "SFUIDisplay-Bold", size: 17)
        label.textColor = UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1)
        setupLayout()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout(){
        addSubview(sectionTitle)
        
        NSLayoutConstraint.activate([
            
            sectionTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            sectionTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
            ])
    }
    
    
}
