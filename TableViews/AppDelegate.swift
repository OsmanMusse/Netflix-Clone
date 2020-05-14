//
//  AppDelegate.swift
//  TableViews
//
//  Created by Mezut on 06/07/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit
import Firebase
import Reachability


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    var reachability:Reachability?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

 
          FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
         
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let initialScreen = initalHomeScreen(collectionViewLayout: layout)
        let navigationController = UINavigationController(rootViewController: initialScreen)
        navigationController.modalPresentationStyle = .fullScreen
        
        window?.backgroundColor = .black
        window?.rootViewController = navigationController
        
        let networkAlertView = NetworkAlertView()
        
          do {
          try reachability = Reachability()
            NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: Notification.Name.reachabilityChanged, object: reachability)
            try reachability?.startNotifier()
          } catch {
               print("This is not working.")
          }
       
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    @objc func reachabilityChanged(note: NSNotification) {
    let reachability = note.object as! Reachability
    if reachability.connection != .unavailable {
        if reachability.connection == .cellular {
        let notification = Notification(name: NotificationName.internetConnectionValid.name)
        NotificationCenter.default.post(notification)
      
    } else {
      print("Reachable via Cellular")
    }
        
    } else {
      let notification = Notification(name: NotificationName.internetConnectionInvalid.name)
      NotificationCenter.default.post(notification)
    }
        
    }


}

