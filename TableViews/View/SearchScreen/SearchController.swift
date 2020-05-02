//
//  SearchController.swift
//  TableViews
//
//  Created by Mezut on 29/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import Firebase

class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    var filmCategory: [VideoCategory]?
    var searchBarHeader: SearchBarHeader?
    
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
      let titleSearchBar = UISearchBar()
        titleSearchBar.delegate = self
        titleSearchBar.barTintColor = UIColor.black
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        titleSearchBar.translatesAutoresizingMaskIntoConstraints = false
        return titleSearchBar
    }()
    

    
    
    
    
    
    let notFoundLabel: UILabel = {
       let label = UILabel()
        label.text = "Your search did not have any results"
        label.textColor = .white
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
var searchTextCharacter: Int?
    
    

    
    override func viewDidLoad() {
        view.backgroundColor = Colors.collectionViewGray
        collectionView.backgroundColor = Colors.collectionViewGray
        collectionView.alpha = 0
        
        
   
    
        
        
        setupCollectionView()
        setupLayout()
        setupFirebaseDatabase()
        
        searchBarHeader = SearchBarHeader()
        
        
        // Database will be written within the view not the controller
        
        // set up the modal
        
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
        if var videoCount =  filmCategory?[1].videoData?.count {
            return filterVideoCollection.count
        }
        
        return filterVideoCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3 - itemsPadding  , height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCellId, for: indexPath) as? SearchViewCell
        
            cell?.videoCollection = filterVideoCollection[indexPath.item]
            return cell!
       
        
    }

    
    

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filterVideoCollection = self.videoCollection.filter { (videos) -> Bool in
            guard let videoName = videos.videoTitle else {return true}
            searchTextCharacter = searchText.count
            return videoName.contains(searchText)
            
        }
        
        if filterVideoCollection.count == 0 {

            
           collectionView.isHidden = true
           collectionView.alpha = 0
           self.notFoundLabel.alpha = 0
            
           guard let textCharacterOptional = searchTextCharacter else {return}
            if textCharacterOptional >= 5 && filterVideoCollection.count == 0 {
                UIView.animate(withDuration: 0.95) {
                    self.notFoundLabel.alpha = 1
                }
            }
        } else if filterVideoCollection.count > 0 {
            

            
            UIView.animate(withDuration: 0.8) {
              
                self.collectionView.isHidden = false
                self.collectionView.alpha = 1
            }
            
            
        }
    
        
   
        self.collectionView.reloadData()

        
    }
    
    
   
    
    
    var videoCollection =  [VideoData]()
    var filterVideoCollection = [VideoData]()
    
    
    
    
    
    func setupFirebaseDatabase(){
        let firebaseDatabase = Database.database().reference()
        
        
        firebaseDatabase.observeSingleEvent(of: .value) { (snapShot) in
            
            guard let dict = snapShot.value as? [String: [Dictionary<String, AnyObject>]] else {return}
            
            guard var firstItem = dict["Videocategories"]  else {return}
            
            guard let videoData = firstItem[0]["videoData"] else {return}
            guard let videoItems = videoData as? [Dictionary<String, AnyObject>] else {return}
            guard let videoUrls = videoItems[0]["videoUrl"] as? String else {return}
            guard let videoName = videoItems[0]["videoTitle"] as? String else {return}
            
            
            for item in videoItems {
                
                guard let videoTitle = item["videoTitle"] as? String else {return}
                
                let singleVideo = VideoData()
                singleVideo.videoTitle = videoTitle
                self.filterVideoCollection.append(singleVideo)
                
                
                print("Filter Video Count == \(self.filterVideoCollection.count)")
                
                self.collectionView.reloadData()
            }
            //Performing The Asynchronous Networking Call
            
            guard let url = URL(string: videoUrls) else {return}
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let image = UIImage(data: data!) else {return}
                
                let video = VideoData()
                video.videoTitle = videoName
                
        
                DispatchQueue.main.async {
                  self.videoCollection.append(video)
                    
                  self.collectionView.reloadData()
                }
              
            }).resume()
            
        }
        

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
        view.addSubview(notFoundLabel)
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
             
             notFoundLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
             notFoundLabel.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 75),
             
            
        
            
            ])
    }
    
    
   
 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}

