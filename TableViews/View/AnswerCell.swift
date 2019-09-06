//
//  AnswerCell.swift
//  TableViews
//
//  Created by Mezut on 08/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit



class CustomTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let videoData: [VideoData] = {
       let video1 = VideoData()
        video1.videoImage = UIImage(named: "bodyguard")
        
        let video2 = VideoData()
        video2.videoImage = UIImage(named: "suits")
        
        
        let video3 = VideoData()
        video3.videoImage = UIImage(named: "bodyguard")
        
        
        let video4 = VideoData()
        video4.videoImage = UIImage(named: "suits")
        
        
        let video5 = VideoData()
        video5.videoImage = UIImage(named: "the-aliens")
        
        
        let video6 = VideoData()
        video6.videoImage = UIImage(named: "suits")
        
        
        return [video1,video2,video3,video4,video5, video6]
        
    }()
    
    let cellId = "cellId"
    let padding: CGFloat = 10

    lazy var customCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor =  UIColor(red: 13/255, green: 13/255, blue: 13/255, alpha: 1)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 18
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        customCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 3 - padding, height: 145)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)as! CustomCell
        cell.backgroundColor = UIColor(red: 13/255, green: 13/255, blue: 13/255, alpha: 1)
        cell.videoData = videoData[indexPath.item]
        cell.layer.cornerRadius = 3
        cell.layer.masksToBounds = true
        self.clipsToBounds = true
        return cell
    }
    
    func setupLayout(){
        addSubview(customCollectionView)
        if let layout = customCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: padding, right: padding)
        }
        NSLayoutConstraint.activate([
            
             customCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
             customCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             customCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             customCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
            ])
    }
}





class CustomCell: UICollectionViewCell {
    
    
    var videoData: VideoData? {
        didSet{
            listImage.image = videoData?.videoImage
        }
    }
    
    let listImage: UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "magnifying-glass (1)"))
        image.translatesAutoresizingMaskIntoConstraints = false
       return image
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(listImage)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout(){
        NSLayoutConstraint.activate([

             listImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             listImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             listImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             listImage.topAnchor.constraint(equalTo: self.topAnchor),

            ])
    }
    
    
    
}
