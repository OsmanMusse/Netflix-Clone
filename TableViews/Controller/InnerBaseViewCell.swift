//
//  InnerBaseViewCell.swift
//  TableViews
//
//  Created by Mezut on 01/02/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//




import UIKit
import Firebase
import  Hero


var imageCache1 = [String: UIImage]()

class InnerBaseViewCell: UICollectionViewCell {
   
    var videoInformation: VideoData? {
        didSet{
            
            guard let imageUrl = videoInformation?.videoName else {return}

            guard let url = URL(string: imageUrl) else {return}

            // Caching Code for the images


            if let cachedImage = imageCache1[imageUrl] {
                self.customImageView.image = cachedImage
                return
            }



            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let err = error {
                    return
                }

                guard let imageData = data else {return}

                let photoImage = UIImage(data: imageData)

                imageCache1[url.absoluteString] = photoImage


                DispatchQueue.main.async {
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
