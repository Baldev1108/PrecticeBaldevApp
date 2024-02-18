//
//  AuthorisedUser.swift
//  FantasyJi
//
//  Created by Gangajaliya Sandeep on 12/22/18.
//  Copyright © 2018 Gangajaliya Sandeep. All rights reserved.
//

import UIKit
import ObjectMapper
import UserNotifications

class AuthorisedUser {
    
    static let shared = AuthorisedUser()
    
    var isAuthorised = false
    var user: UserData?
    var authToken = ""
    var firebaseToken = ""
    var voipPushToken = ""
    var universalLink: String?
    
    func setAuthorisedUser(with data: [String:Any]) {
        
        let uData = data.mapValues { $0 is NSNull ? "" : $0 }
        
        self.user = Mapper<UserData>().map(JSON: uData)
        self.isAuthorised = true
        
        
        UserDefaults.standard.set(Webservice.baseUrl, forKey: "server_url")
        UserDefaults.standard.set(uData, forKey: "UserDetail")
        UserDefaults.standard.synchronize()
        
        self.updateDeviceToken()
    }
    
    func setAuthorisedToken(with authToken: String) {
        self.authToken = authToken
        UserDefaults.standard.set(authToken, forKey: "UserToken")
        UserDefaults.standard.synchronize()
    }
    
    func setVoipToken(with voipToken: String) {
        self.voipPushToken = voipToken
        UserDefaults.standard.set(voipToken, forKey: "VoipToken")
        UserDefaults.standard.synchronize()
    }
    
    func getVoipToken()-> String {
        let voipToken = UserDefaults.standard.value(forKey: "VoipToken") as? String ?? ""
        self.voipPushToken = voipToken
        return voipToken
    }
    
    func removeAuthorisedUser() {
        self.user = nil
        self.isAuthorised = false
        self.authToken = ""
        UserDefaults.standard.removeObject(forKey: "UserDetail")
        UserDefaults.standard.removeObject(forKey: "UserToken")
        UserDefaults.standard.removeObject(forKey: "LoginEmail")
        UserDefaults.standard.removeObject(forKey: "LoginPassword")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.synchronize()
        
        print(UserDefaults.standard.value(forKey: "UserDetail") ?? "Logout")
        
        if (SocketObject.shared.socket != nil && (SocketObject.shared.socket.status == .connected || SocketObject.shared.socket.status == .connecting )) {
            SocketObject.shared.socket.disconnect()
        }
    }
    
    func isUserAuthorised() -> Bool {
        
        if let data = UserDefaults.standard.value(forKey: "UserDetail") as? [String:Any] {
            self.user = Mapper<UserData>().map(JSON: data)
            self.isAuthorised = true
            
            if let authToken = UserDefaults.standard.value(forKey: "UserToken") as? String {
                self.authToken = authToken
            }
            
            if let VoipToken = UserDefaults.standard.value(forKey: "VoipToken") as? String {
                self.voipPushToken = VoipToken
            }
            
            if let serverUrl = UserDefaults.standard.value(forKey: "server_url") as? String {
                if Webservice.baseUrl != serverUrl {
                    return false
                }
            } else {
                return false
            }
            
            print("Token ->", self.authToken)
            print("User data ->", data)
            
            return true
        }
        return false
    }
    
    func logoutUser() {
        let logoutVM = SignupVM()
        logoutVM.logout { (success, msg) in
        }
        
        
        self.removeAuthorisedUser()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
    }
    
    func updateDeviceToken(){
        
        if let _ = UserDefaults.standard.value(forKey: "firebaseToken") as? String {
        }
    }
    func setShownTutorial() {
        UserDefaults.standard.set(true, forKey: "is_show_tutorial")
        UserDefaults.standard.synchronize()
    }
    
    func getShownTutorial()-> Bool {
        return UserDefaults.standard.bool(forKey: "is_show_tutorial")
    }
    
}
