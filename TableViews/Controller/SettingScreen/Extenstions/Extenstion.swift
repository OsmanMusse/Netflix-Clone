//
//  Extenstion.swift
//  TableViews
//
//  Created by Mezut on 08/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

extension SettingScreenHeader: MenuCellDelegate {
    func didTapProfileBtn(viewControllerToPresent: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewControllerToPresent)
        // Action for the Manage Profile Btn
        if let profileController = viewControllerToPresent as? ProfileSelector {
            profileController.pushFromSuperView = false
            profileController.handleEditingMode()
            self.settingScreen?.present(navigationController, animated: true, completion: nil)
            return
        }
        
        // Action for the Add Profile Btn
        if let createController = viewControllerToPresent as? CreateProfileController {
            let profileSelectorNav = UINavigationController(rootViewController: ProfileSelector())
            self.settingScreen?.present(profileSelectorNav, animated: true, completion: {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.10 , execute: {
                    let createControllerNav = UINavigationController(rootViewController: createController)
                    createController.pushFromSuperView = false
                    profileSelectorNav.present(createControllerNav, animated: false, completion: nil)
                    
                })
            })
        }
        self.settingScreen?.present(navigationController, animated: true, completion: nil)
    }
    
    
}
