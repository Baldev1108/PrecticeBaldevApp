//
//  NavigationController.swift
//  DJ Music
//
//  Created by Gangajaliya Sandeep on 24/08/18.
//  Copyright © 2018 Gangajaliya Sandeep. All rights reserved.
//

import UIKit

class NavigationController: InteractiveNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = false
        }
        navigationBar.barTintColor = .white
        navigationBar.backgroundColor = .white
        
//        navigationBar.titleTextAttributes = [NSAttributedString.Key.font : (AppFont.proximaNova.with(weight: .bold, size: 16))!, NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .semibold), NSAttributedString.Key.foregroundColor : UIColor.fontBlackColor]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = UIColor(hex: "#D4D4D4")//Border color
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        
        
    }
    
}
extension UINavigationController {

    func setNavigationBarBorderColor(_ color:UIColor) {
        self.navigationBar.shadowImage = color.as1ptImage()
    }
}

class InteractiveNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    
    //MARK:- UIGestureRecognizerDelegate Methods
    //--------------------------
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if let _ = viewControllers.last as? CompleteProfileVC {
            return false
        }
               
        if let _ = viewControllers.last as? AuthenticateWithPinVC {
            return false
        }
        if let _ = viewControllers.last as? ChatDetailVC {
            return false
        }
        
        
        if(viewControllers.count > 1) {
            return true
        }
        
        return false
    }
    
}
