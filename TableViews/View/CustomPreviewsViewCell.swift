//
//  CustomPreviewsViewCell.swift
//  TableViews
//
//  Created by Mezut on 29/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit


class CustomPreviewsViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let previousVideos: [VideoData] = {
       var video1 = VideoData()
        video1.videoImage = UIImage(named: "ANOTHER-LIFE")
        video1.imageTitle = UIImage(named: "Another-life-title")
        video1.imageBorderColor = UIColor.red
        
        let video2 = VideoData()
        video2.videoImage = UIImage(named: "bodyguard")
        video2.imageTitle = UIImage(named: "Bodyguard-title")
        video2.imageBorderColor = UIColor.orange
        
        let video3 = VideoData()
        video3.videoImage = UIImage(named: "Designated-Survivor")
        video3.imageTitle = UIImage(named: "designate-title")
        video3.imageBorderColor = UIColor.blue
        
        let video4 = VideoData()
        video4.videoImage = UIImage(named: "ANOTHER-LIFE")
        
        let video5 = VideoData()
        video5.videoImage = UIImage(named: "ANOTHER-LIFE")
        
        
        let video6 = VideoData()
        video6.videoImage = UIImage(named: "ANOTHER-LIFE")
        
        let video7 = VideoData()
        video7.videoImage = UIImage(named: "ANOTHER-LIFE")
        
        let video8 = VideoData()
        video8.videoImage = UIImage(named: "ANOTHER-LIFE")
        
        let video9 = VideoData()
        video9.videoImage = UIImage(named: "ANOTHER-LIFE")
        
        let video10 = VideoData()
        video10.videoImage = UIImage(named: "ANOTHER-LIFE")
        
    
        return [video1,video2,video3,video4,video5,video6,video7,video8,video9,video10]
        
        
    }()
    
    let cellId = "cellId"
    let padding: CGFloat = 10

    lazy var customCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        customCollectionView.register(CustomPreviewsInnerCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = customCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        }
       
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.indicatorStyle = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return previousVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 106, height: 106)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomPreviewsInnerCell
        cell.backgroundColor = .clear
        cell.previousVideos = previousVideos[indexPath.item]
        cell.layer.cornerRadius = 53
    
        return cell
    }
    
    
    
    func setupLayout(){
        
        addSubview(customCollectionView)
        
        NSLayoutConstraint.activate([
            
            customCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            customCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            customCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
            ])
        
        
        
        
        
    }
    
    
}


class CustomPreviewsInnerCell: UICollectionViewCell {
    
    var previousVideos: VideoData? {
        didSet {
            previewImage.image = previousVideos?.videoImage
            imageTitle.image = previousVideos?.imageTitle
            if let borderColor = previewImage.layer.borderColor  {
                if let imageBorderColor = previousVideos, let imageUiColor = imageBorderColor.imageBorderColor{
                    let changeToCgColor = imageUiColor.cgColor
         
                    previewImage.layer.borderColor = changeToCgColor
                }
            
            }
        }
    }

    
    let imageTitle: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "Bodyguard-title"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let viewBorderOpacity: CustomView = {
       let view = CustomView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.cornerRadius = 53
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let previewImage: UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "bodyguard"))
        image.layer.cornerRadius = 53
        image.layer.borderWidth = 2
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.orange.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){

        addSubview(previewImage)
        addSubview(viewBorderOpacity)
        addSubview(imageTitle)
        
        
        NSLayoutConstraint.activate([
            
            previewImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            previewImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            previewImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            previewImage.topAnchor.constraint(equalTo: self.topAnchor),
            
            
            viewBorderOpacity.leadingAnchor.constraint(equalTo: previewImage.leadingAnchor),
            viewBorderOpacity.bottomAnchor.constraint(equalTo: previewImage.bottomAnchor),
            viewBorderOpacity.trailingAnchor.constraint(equalTo: previewImage.trailingAnchor),
            viewBorderOpacity.topAnchor.constraint(equalTo: previewImage.topAnchor),


            imageTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
            imageTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor)

        
            
            ])
    }
    
    
}



class CustomView:UIView {
    
    var gradient: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setupLayout()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        var gradient = CAGradientLayer()
        gradient = CAGradientLayer()
        let firstColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let secondColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        let thirdColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.86)
        let fourColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        let colors: [CGColor] = [firstColor.cgColor,secondColor.cgColor, thirdColor.cgColor, fourColor.cgColor]
        gradient.colors = colors
        gradient.startPoint = CGPoint(x: 0.0, y: 0.65)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.addSublayer(gradient)
        self.gradient = gradient
        
        
    }
    
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        gradient?.frame = self.bounds
    }
    
    
}
