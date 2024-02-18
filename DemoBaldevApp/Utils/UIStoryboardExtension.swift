//
//  UIStoryboardExtension.swift
//  FantasyJi
//
//  Created by Gangajaliya Sandeep on 12/22/18.
//  Copyright © 2018 Gangajaliya Sandeep. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static let authentication: UIStoryboard = {
        return UIStoryboard.init(name: "Authentication", bundle: nil)
    }()
    
    static let mainTabBar: UIStoryboard = {
        return UIStoryboard.init(name: "MainTabBar", bundle: nil)
    }()
    
    static let chat: UIStoryboard = {
        return UIStoryboard.init(name: "Chat", bundle: nil)
    }()
    
    static let toDos: UIStoryboard = {
        return UIStoryboard.init(name: "ToDos", bundle: nil)
    }()
    
    static let schedule: UIStoryboard = {
        return UIStoryboard.init(name: "Schedule", bundle: nil)
    }()
    
    static let plans: UIStoryboard = {
        return UIStoryboard.init(name: "Plans", bundle: nil)
    }()
    
    static let notifications: UIStoryboard = {
        return UIStoryboard.init(name: "Notifications", bundle: nil)
    }()
    
    static let profile: UIStoryboard = {
        return UIStoryboard.init(name: "Profile", bundle: nil)
    }()
    
    static let chatMessage: UIStoryboard = {
        return UIStoryboard.init(name: "ChatMessage", bundle: nil)
    }()
    
    class func setAuthenticationAsRootView() {
        AuthorisedUser.shared.logoutUser()
        let rootViewController = self.authentication.instantiateInitialViewController()
        appDelegate.window?.rootViewController = rootViewController
    }
    
    class func setMainTabBarAsRootView() {
        
        let rootViewController = self.mainTabBar.instantiateInitialViewController()
        appDelegate.window?.rootViewController = rootViewController
    }
}
