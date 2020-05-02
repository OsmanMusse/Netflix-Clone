//
//  ProfileModel.swift
//  TableViews
//
//  Created by Mezut on 23/03/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit


class ProfileModel: Equatable{
    static func == (lhs: ProfileModel, rhs: ProfileModel) -> Bool {
        return lhs.profileName == rhs.profileName
    }
    
    var profileName: String
    var profileImage: String
    var isActive: Bool?
    var userIdentifier: String?
    
    init(profileName: String, profileImage: String) {
        self.profileName = profileName
        self.profileImage = profileImage
    }
}
