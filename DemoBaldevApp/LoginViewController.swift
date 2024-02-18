//
//  LoginViewController.swift
//  SpeakBlock
//
//  Created by Baldev Foremost on 15/09/22.
//

import UIKit

class LoginViewController: UIViewController {

    var signupVM = SignupVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        do {
//           let isUpdateRequired =  try ProjectUtilities.isUpdateAvailable()
//            if isUpdateRequired {
//                AppUpdateVC.present(openFromVc: self)
//                return
//            }
//        } catch {
//            print(error)
//        }
        
        
        if AuthorisedUser.shared.isUserAuthorised() {
       
//            SignUpAddDetailVC.open(nav: self.navigationController, signupVM: SignupVM(), currentColIndex: 2)
//            return

            
            //Api call for data in background
            if (!appDelegate.isCallOngoing) {
                signupVM.getMyProfile { isSuccess, msg in
                    print(isSuccess)
                    
                }
            }
            
            guard let user = AuthorisedUser.shared.user else { return }
            
            
            
            if user.username.isEmpty {
                AuthorisedUser.shared.logoutUser()
                UIStoryboard.setAuthenticationAsRootView()
//                SignUpAddDetailVC.open(nav: self.navigationController, signupVM: SignupVM(), currentColIndex: 2)
            } else if user.profile_photo.isEmpty {
                AuthorisedUser.shared.logoutUser()
                UIStoryboard.setAuthenticationAsRootView()
//                CompleteProfileVC.open(nav: self.navigationController)
            } else if user.push_notification == 0 {
                AllowPushNotificationVC.open(nav: self.navigationController)
            } else {
                if !user.app_pin_code.isEmpty {
                    AuthenticateWithPinVC.open(nav: self.navigationController)
                } else {
                    UIStoryboard.setMainTabBarAsRootView()
                }
            }
        } else {
            
            
            UserDefaults.standard.removeObject(forKey: "UserDetail")
            UserDefaults.standard.removeObject(forKey: "UserToken")
            UserDefaults.standard.removeObject(forKey: "LoginEmail")
            UserDefaults.standard.removeObject(forKey: "LoginPassword")
            UserDefaults.standard.synchronize()
            UserDefaults.standard.synchronize()
            
            let center = UNUserNotificationCenter.current()
            center.removeAllDeliveredNotifications()
            center.removeAllPendingNotificationRequests()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginClicked(_ sender: UIButton) {
        signupVM.inviteCode = "M06KvA"
        signupVM.isLogin = true
        SignUpAddDetailVC.open(nav: self.navigationController, signupVM: self.signupVM)
    }
    @IBAction func signUpClicked(_ sender: UIButton) {
//        InviteCodeVC.open(nav: self.navigationController)
        WelcomeVC.open(nav: self.navigationController)
    }
    @IBAction func termClicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string:"https://speakblock.com/terms-of-service")!)
    }
    @IBAction func privacyClicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string:"https://speakblock.com/privacy-policy")!)
    }
    
}
extension LoginViewController {
    class func open(nav: UINavigationController?) {
        let vc = UIStoryboard.authentication.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        nav?.pushViewController(vc, animated: true)
    }
}
