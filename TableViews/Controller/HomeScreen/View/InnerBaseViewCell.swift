//
//  InnerBaseViewCell.swift
//  TableViews
//
//  Created by Mezut on 01/02/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//




import UIKit
import Firebase
import Hero


var videoImageCache = [String: UIImage]()

class InnerBaseViewCell: UICollectionViewCell {
   
    var videoData: VideoData? {
        didSet{
            
            guard let videoURL = videoData?.videoURL else {return}
            guard let url = URL(string: videoURL) else {return}
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if let err = err {
                    print(err)
                }
                
                if url.absoluteString != videoURL {
                    return
                }
                
                
                guard let data = data else {return}
                
                guard let constructedImage = UIImage(data: data) else {return}
         
                DispatchQueue.main.async {
                    self.customImageView.image = constructedImage
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
