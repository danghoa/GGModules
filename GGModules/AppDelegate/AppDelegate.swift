//
//  AppDelegate.swift
//  GGModuleLogin
//
//  Created by Đăng Hoà on 1/11/17.
//  Copyright © 2017 Green Global. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = UIColor.white
    window?.makeKeyAndVisible()
    
    let signIn = GGMSignInVC(social: GGMSignInVC.Social.facebook, mainColor: UIColor.magenta, name: "Jonas Brothers")
    
    signIn.setting(backgroundColor: nil, backgroundImage: nil, imageFacebook: nil, imageGoogle: nil)
    
    signIn.settingAPI(path: "http://api-swivel-dev.greenglobal.vn:8100/auth/login")
    
    signIn.response { (type, detail, value) in
      
      if type == GGMSignInVC.Response.successfully {
        
      } else if type == GGMSignInVC.Response.failed {
        
      } else if type == GGMSignInVC.Response.forgot {
        
      } else if type == GGMSignInVC.Response.signUp {
        
      } else {
        
      }
      //print(type, detail, value)
    }
    window?.rootViewController = signIn
    
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


}

