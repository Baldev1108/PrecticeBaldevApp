//
//  SignupVM.swift
//  SpeakBlock
//
//  Created by Gangajaliya Sandeep on 11/09/21.
//

import UIKit
import Firebase
import ObjectMapper

class SignupVM: NSObject {
    
    var inviteCode = ""
    var isLogin = false
    
    var country_code = "+1"
    var country = "+1 - Canada (CA)"
    var phoneNumber = ""
    var verificationID = ""
    var otp = ""

    var first_name = ""
    var last_name = ""
    var username = ""
    
    func existsInviteCode(completion:@escaping(Bool, String?) -> ()) {
        
        let params = ["invite_code": inviteCode] as [String: Any]
        
        Webservice.Authentication.existsInviteCode(parameter: params) { (result) in
            
            switch result {
            case .success(let response):
                
                if let _ = response.body {
                    
                    completion(true, nil)
                    return
                }
                completion(false, response.message)
                
            case .fail(let errorMsg):
                print(errorMsg)
                completion(false, errorMsg)
            }
        }
    }
    
    func phoneExists(completion:@escaping(Bool, String?) -> ()) {
        
        let params = ["phone": phoneNumber] as [String: Any]
                
        Webservice.Authentication.phoneExists(parameter: params) { (result) in
            
            switch result {
            case .success(let response):
                
                if let _ = response.body {
                    
                    self.sendOtp { (success) in
                        if success {
                            completion(true, nil)
                            return
                        }
                        completion(false, response.message)
                    }
                } else {
                    completion(false, response.message)
                }
                
            case .fail(let errorMsg):
                print(errorMsg)
                completion(false, errorMsg)
            }
        }
    }
    
    func phoneExistsLogin(completion:@escaping(Bool, String?) -> ()) {
        
        let params = ["phone": phoneNumber] as [String: Any]
                
        Webservice.Authentication.phoneExists(parameter: params) { (result) in
            
            switch result {
            case .success(let response):
                
                if let body = response.body, let status = body["status"] as? Bool, status {
                    
                    completion(true, response.message)
                } else {
                    completion(false, response.message)
                }
                
            case .fail(let errorMsg):
                print(errorMsg)
                completion(false, errorMsg)
            }
        }
    }
    
    func sendOtp(completion: @escaping(Bool) -> ()) {
                
        PhoneAuthProvider.provider().verifyPhoneNumber(country_code + phoneNumber, uiDelegate: nil) { [weak self] (verificationID, error) in
                        
            if let error = error {
                if error.localizedDescription == "TOO_LONG" {
                    ProjectUtilities.showMessageToast("Your phone number is too long!")
                } else {
                    ProjectUtilities.showMessageToast(error.localizedDescription)
                }
                
            }
            if let verificationID = verificationID {
                self?.verificationID = verificationID
                completion(true)
                return
            }
            
            completion(false)
        }
    }
    
    func verifyOtp(completion: @escaping(Bool) -> ()) {
                
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otp)
        Auth.auth().signIn(with: credential) { (user, error) in
                        
            if let error = error {
                ProjectUtilities.showMessageToast(error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func updatePhone(completion:@escaping(Bool, String?) -> ()) {
        var localTimeZoneAbbreviation: String { return TimeZone.current.identifier }
        let params = ["country_code": country_code, "country": country, "phone": phoneNumber, "invite_code": inviteCode, "firebase_ios_id": AuthorisedUser.shared.firebaseToken, "voip_push_token": AuthorisedUser.shared.voipPushToken,"timezone": localTimeZoneAbbreviation] as [String: Any]
                
        Webservice.Authentication.updatePhone(parameter: params) { (result) in
            
            switch result {
            case .success(let response):
                
                if let body = response.body, let user = body["data"] as? [String: Any] {
                    
                    AuthorisedUser.shared.setAuthorisedUser(with: user)
                    
                    if let token = body["token"] as? String {
                        AuthorisedUser.shared.setAuthorisedToken(with: token)
                    }
                    
                    completion(true, nil)
                    return
                }
                completion(false, response.message)
                
            case .fail(let errorMsg):
                print(errorMsg)
                completion(false, errorMsg)
            }
        }
    }
    
    func getMyProfile(completion:@escaping(Bool, String?) -> ()) {
        
        
        if AuthorisedUser.shared.voipPushToken == "" {
            AuthorisedUser.shared.voipPushToken = AuthorisedUser.shared.getVoipToken()
        }
        
        var localTimeZoneAbbreviation: String { return TimeZone.current.identifier }
                let param = ["invite_code": inviteCode, "firebase_ios_id": AuthorisedUser.shared.firebaseToken, "voip_push_token": AuthorisedUser.shared.voipPushToken,"timezone": localTimeZoneAbbreviation] as [String: Any]
        Webservice.Authentication.getMyProfile(parameter: param) { (result) in
            
            switch result {
            case .success(let response):
                
                if let body = response.body, let user = body["data"] as? [String: Any] {
                    
                    AuthorisedUser.shared.setAuthorisedUser(with: user)
                    
                    if let ios_app_version = body["ios_version"] as? String, let ios_version = Float(ios_app_version){
                        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let version = Float(appVersion) {
                            
                            if version < ios_version {
                                if let vc = ProjectUtilities.getCurrentNavigation() {
                                    AppUpdateVC.present(openFromVc: vc)
                                }
                            }
                        }
                    }
                    
                    
                    completion(true, nil)
                    return
                }
                completion(false, response.message)
                
            case .fail(let errorMsg):
                print(errorMsg)
                completion(false, errorMsg)
            }
        }
    }
    
   
    
    func logout(completion:@escaping(Bool, String?) -> ()) {
                
        let params =  [String: Any]()
                
        Webservice.Authentication.logout(parameter: params) { (result) in
            
            switch result {
            case .success(let response):
                
                if let body = response.body, let status = body["status"] as? Bool, status {
                    
                   
                    return
                }
                completion(false, response.message)
                
            case .fail(let errorMsg):
                print(errorMsg)
                completion(false, errorMsg)
            }
        }
    }
    
    func updateProfile(completion:@escaping(Bool, String?) -> ()) {
                
        let params = ["first_name": first_name, "last_name": last_name, "username": username] as [String: Any]
                
        Webservice.Authentication.updateProfile(parameter: params) { [weak self] (result) in
            
            switch result {
            case .success(let response):
                
                if let _ = response.body, let selff = self {
                    
                    if let data = UserDefaults.standard.value(forKey: "UserDetail") as? [String: Any] {
                        var userData = data
                        userData["first_name"] = selff.first_name
                        userData["last_name"] = selff.last_name
                        userData["username"] = selff.username
                        userData["name"] = selff.first_name + " " + selff.last_name
                        
                        AuthorisedUser.shared.setAuthorisedUser(with: userData)
                    }
                    
                    completion(true, nil)
                    return
                }
                completion(false, response.message)
                
            case .fail(let errorMsg):
                print(errorMsg)
                completion(false, errorMsg)
            }
        }
    }
}
