//
//  AppDelegate.swift
//  VKNewsFeed
//
//  Created by Алексей Пархоменко on 20/02/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegateProtocol {
    
    var window: UIWindow?
    var authService: AuthService!
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        self.authService = AuthService()
        authService.delegate = self
        
        let authVC: AuthViewController = AuthViewController.loadFromStoryboard()
        
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
    


    // MARK: AuthServiceDelegate
    
    func authServiceShouldShow(_ viewController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {
        print(#function)
        let feedVC: NewsfeedViewController = NewsfeedViewController.loadFromStoryboard()
        let navVC = UINavigationController(rootViewController: feedVC)
        window?.rootViewController = navVC
    }
    
    func authServiceDidSignInFail() {
        print(#function)
    }

}

