//
//  ViewController.swift
//  DemoBaldevApp
//
//  Created by Baldev Foremost on 15/02/24.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - VARS And OBJECTS
    var authModal = AuthViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //MARK: - ACTIONS
    @IBAction func fLoginClicked(_ sender: UIButton) {
            
        authModal.loginWithFacebook { success, value in
            if success {
                print("token ::: ",value)
                if let value = value {
                    authFacebookTokenWithAws(value)
                } else {
                    //SHOW ERROR MESSAGE
                }
                
            } else {
                //SHOW MESSAGE
            }
        }
        
    }
    
    //MARK: AUTHENTICATE WITh AWS
    private func authFacebookTokenWithAws(_ token: String) {
        authModal.logins(token)
    }
    
}

