//
//  InnerImagePickerCell.swift
//  TableViews
//
//  Created by Mezut on 01/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import SVProgressHUD

var imagePickerCache = [String: UIImage]()

class InnerImagePickerCell: UICollectionViewCell {
    
    var imagePickerData: String? {
        didSet{
            // Networking Code to get the image
            
            guard let pickerImage = imagePickerData else {return}
            
            if let cachedImage = imagePickerCache[pickerImage] {
                self.pickerImage.image = cachedImage
                return
            }
            guard let url = URL(string: pickerImage) else {return}
            
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                
                if let err = err {
                    print("Error with get the image from the URL", err)
                }
                
                guard let data = data else {return}
                
                guard let imageData = UIImage(data: data) else {return}
                
                imagePickerCache[url.absoluteString] = imageData
                
                DispatchQueue.main.async {
                    self.pickerImage.image = imageData
                }
   
            }.resume()
        }
    }
    
    
    let pickerImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    func setupLayout(){
        addSubview(pickerImage)
        
        NSLayoutConstraint.activate([
            
            pickerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pickerImage.topAnchor.constraint(equalTo: self.topAnchor),
            pickerImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pickerImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
