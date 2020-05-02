//
//  PopularCollectionViewCell.swift
//  NetflixApp
//
//  Created by Mezut on 25/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let StringpopularHeaderCellId = "StringpopularHeaderCellId"
    
    
    
  
    
    lazy var customCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 9.0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        customizeCollectionView()
        customCollectionView.register(PopularCustomCell.self, forCellWithReuseIdentifier: cellId)
        customCollectionView.register(PopularCustomHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StringpopularHeaderCellId)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = customCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StringpopularHeaderCellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 40)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PopularCustomCell
        
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        return cell
    }
    
    func customizeCollectionView(){
      
    }
    
    
    
    
    func setupLayout(){
        addSubview(customCollectionView)
        
        NSLayoutConstraint.activate([
            
            customCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            customCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            customCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customCollectionView.heightAnchor.constraint(equalToConstant: 700)
            
            
            ])
    }
    
    
    
}


class PopularCustomHeader: UICollectionViewCell {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular on Netflix"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            
            headerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
            ])
    }

}

class PopularCustomCell: UICollectionViewCell {
    
    var popularVideos: VideoData? {
        didSet {
        
            
            
        }
    }
    

    let videoImage: UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "romance-image"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let firstImageLabel: UILabel = {
       let label = UILabel()
        let changedText = NSMutableAttributedString(string: "Workplace", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        changedText.append(NSAttributedString(string: " \u{2022}", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange]))
        label.attributedText = changedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondImageLabel: UILabel = {
        let label = UILabel()
        let changedText = NSMutableAttributedString(string: "Korean", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        changedText.append(NSAttributedString(string: " \u{2022}", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange]))
        label.attributedText = changedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let thirdImageLabel: UILabel = {
        let label = UILabel()
        label.text = "Sentimental"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout(){
        
     
        let videoTagStackView = UIStackView(arrangedSubviews: [firstImageLabel, secondImageLabel, thirdImageLabel])
        videoTagStackView.axis = .horizontal
        videoTagStackView.distribution = .fill
        videoTagStackView.translatesAutoresizingMaskIntoConstraints = false
        videoTagStackView.spacing = 5
    
        
        
        addSubview(videoImage)
        addSubview(videoTagStackView)
        
        
        NSLayoutConstraint.activate([
             videoImage.topAnchor.constraint(equalTo: self.topAnchor),
             videoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             videoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             videoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             
             videoTagStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
             videoTagStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            
            
            ])
    }
    
    
}
