//
//  Extension.swift
//  TableViews
//
//  Created by Mezut on 08/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit
import Firebase



extension Firebase.Database {
    static func getUserProfile(userID: String, completion: @escaping (ProfileModel) -> Void){
        Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").observeSingleEvent(of: .value) { (snapShot) in
    
        guard let dictionary = snapShot.value as? [String: Any] else {return}
         let profileKey = snapShot.key
            
            print(dictionary)
            
            
            for item in dictionary {
                guard let profileValue = item.value as? [String: Any] else {return}
                guard let profileName = profileValue["ProfileName"] as? String else {return}
                guard let profileURL = profileValue["ProfileURL"] as? String else {return}
                let createDictonary = ProfileModel(profileName: profileName, profileImage: profileURL)
                createDictonary.userIdentifier = profileKey
                if let isProfileActive = profileValue["isActive"] as? Bool {
                    createDictonary.isActive = isProfileActive
                }
                completion(createDictonary)
            }
            
            
        }
        
    }
    
    static func getUpdatedUserProfile(userID: String, dataEventType: DataEventType, completion: @escaping (ProfileModel) -> Void){
        Firebase.Database.database().reference().child("Users").child(userID).child("Profiles").queryOrdered(byChild: "createdDate") .observe(dataEventType) { (snapShot) in
            
            guard let dictionary = snapShot.value as? [String: Any] else {return}
            let profileKey = snapShot.key
            
            print(dictionary)
            
            guard let profileName = dictionary["ProfileName"] as? String else {return}
            guard let profileURL = dictionary["ProfileURL"] as? String else {return}
            let createUser = ProfileModel(profileName: profileName, profileImage: profileURL)
            createUser.userIdentifier = profileKey
            if let isProfileActive = dictionary["isActive"] as? Bool {
                createUser.isActive = isProfileActive
            }
            completion(createUser)

        }
        
    }
    
    
    
    
    
}



