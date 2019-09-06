//
//  ViewController.swift
//  TableViews
//
//  Created by Mezut on 06/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit

class HomeScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var videoCategory: [VideoCategory]?
    

    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.grouped)
        view.delegate = self
    
        view.dataSource = self
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    let seriesBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Series", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let filmsBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Films", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let myListBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("My List", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
 

    
    
    let cellId = "cellId"
    let myListCellId = "myListCellId"
    let popularCellId = "popularCellId"
    let previewsCellId = "previewsCellId"
    let RecentlyAddedCellId = "RecentlyAddedCellId"
    let VideoViewCellId = "VideoViewCellId"
    
    override func viewDidLoad() {
        // intermediate the modal
        
        videoCategory = VideoCategory.getVideoCategory()
        
          print(" The Video Information\(videoCategory?[0].videoData?[1].videoName)")
        
        navigationController?.hidesBarsOnSwipe = true
        view.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
       tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(MyListViewCell.self, forCellReuseIdentifier: myListCellId)
        tableView.register(CustomPopularViewCell.self, forCellReuseIdentifier: popularCellId)
        tableView.register(CustomPreviewsViewCell.self, forCellReuseIdentifier: previewsCellId)
        tableView.register(RecentlyAddedCell.self, forCellReuseIdentifier: RecentlyAddedCellId)
        tableView.register(VideoViewCell.self, forCellReuseIdentifier: VideoViewCellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        self.tabBarController?.tabBar.barTintColor = .black
        self.tabBarController?.tabBar.isTranslucent = false
        
        setupNavBar()
        setupLayout()

    }
    
  
    

    
    func setupNavBar(){
        
      
    
        let netflixLogo = UIBarButtonItem(image: #imageLiteral(resourceName: "netflix (1)").withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        netflixLogo.imageInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        
        let label = UIBarButtonItem(title: "hadsa", style: .plain, target: nil, action: nil)
        let sview = UIStackView(arrangedSubviews: [seriesBtn,filmsBtn,myListBtn])
        sview.axis = .horizontal
        sview.alignment = .center
        sview.spacing = 50
        sview.distribution = .fillEqually
        sview.translatesAutoresizingMaskIntoConstraints = false
        
        let customView = UIBarButtonItem(customView: sview)
        self.navigationController?.navigationBar.backgroundColor = .red
        
        navigationItem.setRightBarButtonItems([customView], animated: false)
        
        
        
        navigationItem.leftBarButtonItem = netflixLogo
        
        
        // Hide the default back button
        navigationItem.hidesBackButton = true
        
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 39/255, blue: 39/255, alpha: 1)
        
    
        navigationController?.navigationBar.isTranslucent = false
        
        
        
    }
    

    func goToVideoController(video: VideoData) {
        let layout = StretchyHeaderLayout()
        let singleVideoController = SingleVideoController(collectionViewLayout: layout)
        singleVideoController.video = video
        singleVideoController.modalPresentationStyle = .overCurrentContext
        singleVideoController.modalTransitionStyle = .coverVertical
        self.present(singleVideoController, animated: true, completion: nil)
    }
    
  
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var sectionHeader =  ["Previews","My List","Popular on Netflix","Recently Added","Trending Now","Top Picks for You","Section 7","Section 8","Section 9"]
        
    
        let label = UITextView()
        label.textColor = .white
        label.font = UIFont(name: "SFUIDisplay-Bold", size: 17)
        label.backgroundColor =  .clear
        label.isSelectable = false
        label.textDragInteraction?.isEnabled = false
        label.textContainerInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        tableView.sectionHeaderHeight = 30
     
        
        
        
        switch section {
        case 0: label.text = sectionHeader[0]
        case 1: label.text = sectionHeader[1]
        case 2: label.text = sectionHeader[2]
        case 3: label.text = sectionHeader[3]
        case 4: label.text = sectionHeader[4]
        case 5: label.text = sectionHeader[5]
        case 6: label.text = sectionHeader[6]
        case 7: label.text = sectionHeader[7]
        case 8: label.text = sectionHeader[8]
        case 9: label.text = sectionHeader[9]
            
        default: label.text = "Problem with finding tableview title"
        }
        
        return label
    }
  

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0 : return 120
        case 1,2,3: return 150
        case 4: return 325
        default: return 350
        }
        
       
    }
    
    

    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: previewsCellId, for: indexPath)
            cell.selectionStyle = .none
            return cell
        case 1:  let cell = tableView.dequeueReusableCell(withIdentifier: myListCellId, for: indexPath) as! MyListViewCell
        cell.videoCategory = videoCategory?[0]
        cell.HomeController = self
        cell.selectionStyle = .none
        return cell
            
        case 2: let cell = tableView.dequeueReusableCell(withIdentifier: popularCellId, for: indexPath)
            cell.selectionStyle = .none
            return cell
            
        case 3: let cell = tableView.dequeueReusableCell(withIdentifier: RecentlyAddedCellId, for: indexPath) as! RecentlyAddedCell
        cell.videoCategory = videoCategory?[0]
        cell.selectionStyle = .none
        return cell
            
        case 4: let cell = tableView.dequeueReusableCell(withIdentifier: VideoViewCellId, for: indexPath) as! VideoViewCell
        cell.selectionStyle = .none
        return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
}
    
    func setupLayout(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([


            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),


            ])
    }
    
 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        
    }
    
    
   
    
    
}
