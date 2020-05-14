//
//  CustomImageView.swift
//  TableViews
//
//  Created by Mezut on 15/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    func loadImage(urlString: String){
        
     guard let url = URL(string: urlString) else {return}
     URLSession.shared.dataTask(with: url) { (data, response, err) in
         if let err = err {
             print(err)
         }
                  
         
         guard let data = data else {return}
         
         guard let constructedImage = UIImage(data: data) else {return}
  
         DispatchQueue.main.async {
            self.image = constructedImage
         }
     }.resume()
    }
}
