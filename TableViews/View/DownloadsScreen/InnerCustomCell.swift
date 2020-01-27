//
//  InnerCustomCell.swift
//  TableViews
//
//  Created by Mezut on 27/01/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Firebase

class InnerCustomCell: UICollectionViewCell {
    
    var videoInformation: VideoData? {
        didSet{
            guard let imageUrl = videoInformation?.videoName else {return}
            print("thE IMAGE URL == \(imageUrl)")
            
            guard let url = URL(string: imageUrl) else {return}
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let err = error {
                    print("failled error")
                    return
                }
                
                guard let imageData = data else {return}
                

                
                
                let photoImage = UIImage(data: imageData)
                
           
        
                
                DispatchQueue.main.sync {
                    self.customImageView.image = photoImage
                }
                
            }.resume()
        }
    }

    var customImageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        backgroundColor = .orange
    }
    
    
    
    func setupLayout(){
        addSubview(customImageView)
        
        NSLayoutConstraint.activate([
            
            customImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customImageView.topAnchor.constraint(equalTo: self.topAnchor),
            customImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
