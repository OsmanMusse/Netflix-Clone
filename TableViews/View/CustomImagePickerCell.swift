//
//  CustomImagePickerCell.swift
//  TableViews
//
//  Created by Mezut on 31/03/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Firebase


protocol CustomImageCellDelegate {
    func didTapInnerCell(tappedImageString: String)
}

class CustomImagePickerCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout{

    var customPickerDelegate:CustomImageCellDelegate?
    
    var imagePickerInformation: ImagePicker?  {
        didSet{
            ImageTitleLabel.text = imagePickerInformation?.categoryTitle
    
        }
    }
    
    var selectorController: ImageSelectorController?
   
    private let imageCellID = "IMAGECELLID"

    let ImageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imagePickerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let colletionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.backgroundColor = .clear
        colletionView.showsHorizontalScrollIndicator = false
        colletionView.translatesAutoresizingMaskIntoConstraints = false
        return colletionView
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupLayout()
    }
    
    
    func setupCollectionView(){
        imagePickerCollectionView.register(InnerImagePickerCell.self, forCellWithReuseIdentifier: imageCellID)
   
        // Gives the collectionview spacing from the left to the right side
        if let layout = imagePickerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let imageCount = imagePickerInformation?.pickerImages.count else {return 0}
        return imageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagePickerCollectionView.dequeueReusableCell(withReuseIdentifier: imageCellID, for: indexPath) as! InnerImagePickerCell
        
        guard let imagesValues = imagePickerInformation?.pickerImages.map({$0.value}) else {return cell}
        let individualImage = imagesValues[indexPath.item]
        cell.imagePickerData = individualImage
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let images = imagePickerInformation?.pickerImages else {return}
        let values = images.map({$0.value})
        let specificImageClicked = values[indexPath.item]
        
        customPickerDelegate?.didTapInnerCell(tappedImageString: specificImageClicked)
        
        selectorController?.goToCreateControllerWithImage(image:specificImageClicked)
        
        
    }
    
    func setupLayout(){
        addSubview(ImageTitleLabel)
        addSubview(imagePickerCollectionView)
        
        NSLayoutConstraint.activate([
            
             ImageTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
             ImageTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
             
             imagePickerCollectionView.topAnchor.constraint(equalTo: self.ImageTitleLabel.bottomAnchor, constant: 0),
             imagePickerCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             imagePickerCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             imagePickerCollectionView.heightAnchor.constraint(equalToConstant: 150)

            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
