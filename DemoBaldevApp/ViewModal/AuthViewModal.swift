//
//  AuthViewModal.swift
//  DemoBaldevApp
//
//  Created by Baldev Foremost on 15/02/24.
//

import Foundation
import FacebookCore
import FacebookLogin
import AWSMobileClient
import AWSIdentityProviderManager

class AuthViewModal: NSObject {
    
    
    
    
    
    func loginWithFacebook(completion:@escaping(Bool, String?) -> ()) {
        
        let loginManager = LoginManager()
        
        // Request permissions from the user
        loginManager.logIn(permissions: [.publicProfile, .email]) { (result) in
            switch result {
            case .success(granted: _, declined: _, token: let accessToken):
                // Exchange Facebook access token with AWS credentials
                let tokenString = accessToken.tokenString
                completion(true,tokenString)
            case .failed(let error):
                print("Facebook login failed with error: \(error)")
                completion(false,error.localizedDescription)
            case .cancelled:
                print("Facebook login was cancelled")
                completion(false, nil)
            }
        }
    }
    
    func logins(_ authenticationToken: String) {
        
    }
}
