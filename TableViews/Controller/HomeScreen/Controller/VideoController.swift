//
//  videoController.swift
//  TableViews
//
//  Created by Mezut on 26/04/2020.
//  Copyright © 2020 Mezut. All rights reserved.
//

import UIKit

class VideoController: UIViewController {
    
    var controlView:CustomVideoControlView?
    
    override func viewDidLoad() {
        
    }
    
    func showAlertController(){
        let alertAction = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            self.controlView = CustomVideoControlView()
            self.controlView?.handleExitMode()
        }
        
        let alertController = self.createAlertController(title: NetworkingAlert.invalidInternet.title, message: NetworkingAlert.invalidInternet.message, alertAction: alertAction)
  
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.present(alertController, animated: true, completion: nil)
        }
      
    }
}
