//
//  SearchController.swift
//  TableViews
//
//  Created by Mezut on 29/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import Firebase

class SearchController: UICollectionViewController, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    var filmCategory: [VideoCategory]?
    
    let placeholderWidth: CGFloat = -265
    var offset = UIOffset()
    
    
    // config for collectionView
    let searchBarHeaderCellId = "searchBarHeaderCellId"
    let searchCellId = "searchCellId"
    let padding: CGFloat = 10
    let itemsPadding: CGFloat = 13
    
    
    let blackSearchBarView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
      let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.black
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    

    
    override func viewDidLoad() {
        collectionView.backgroundColor = Colors.collectionViewGray
        setupCollectionView()
        setupLayout()
        
        var firebaseDatabase = Database.database().reference().child("Categories")
        var firebaseStorage  = Storage.storage().reference()
  
        
        firebaseDatabase.observeSingleEvent(of: DataEventType.value) { (snapShot: DataSnapshot) in
            print(snapShot)
            
            
        }
        
        print("This is the database Info \(firebaseDatabase)")
        // set up the modal
        filmCategory = VideoCategory.getVideoCategory()
        
        collectionView.alwaysBounceVertical = true
        // Hack to get the textfield placeholder to center in the search bar
        
        offset = UIOffset(horizontal: (searchBar.frame.width - placeholderWidth) / 2, vertical: 0)
        searchBar.setPositionAdjustment(offset, for: .search)
        
        searchBar.sizeToFit()
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1)])
            if let backgroundview = textfield.subviews.first {
                backgroundview.layer.cornerRadius = 1;
                backgroundview.clipsToBounds = true;
            }
        }
        
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = padding
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: 0, right: padding)
        }
    }
    
    
    func setupCollectionView(){
        collectionView.register(SearchBarHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: searchBarHeaderCellId)
        collectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: searchCellId)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 33)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: searchBarHeaderCellId, for: indexPath) as? SearchBarHeader
        return cell!
    }
    

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let videoCount =  filmCategory?[1].videoData?.count {
            return videoCount
        }
        
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3 - itemsPadding  , height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCellId, for: indexPath) as? SearchViewCell
        if let filmCollection = filmCategory?[1].videoData?[indexPath.item] {
            cell?.filmVideos = filmCollection
            return cell!
        }
    
        return cell!
       
        
    }
 
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let noOffset = UIOffset(horizontal: 0, vertical: 0)
        searchBar.setPositionAdjustment(noOffset, for: .search)
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setPositionAdjustment(offset, for: .search)
        
        return true
    }
    
    
    func setupLayout(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blackSearchBarView)
        blackSearchBarView.addSubview(searchBar)
        NSLayoutConstraint.activate([
            
            blackSearchBarView.topAnchor.constraint(equalTo: self.view.topAnchor),
            blackSearchBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            blackSearchBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            blackSearchBarView.heightAnchor.constraint(equalToConstant: 100),
            blackSearchBarView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            
            
            searchBar.bottomAnchor.constraint(equalTo: blackSearchBarView.bottomAnchor, constant: 5),
            searchBar.leadingAnchor.constraint(equalTo: self.blackSearchBarView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.blackSearchBarView.trailingAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            
            
            collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
             collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        
            
            ])
    }
    
    
   
 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}

class SearchViewCell: UICollectionViewCell {
    
    var filmVideos: VideoData? {
        didSet{
            listImage.image = filmVideos?.videoImage
        }
    }
    
    let listImage: UIImageView = {
      let image = UIImageView(image: #imageLiteral(resourceName: "the-end-of-the-world"))
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
        addSubview(listImage)
        
        NSLayoutConstraint.activate([
            
            listImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            listImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            listImage.topAnchor.constraint(equalTo: self.topAnchor),
            listImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            ])
    }
    
    
}
