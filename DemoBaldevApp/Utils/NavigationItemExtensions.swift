
//  Created by Sandeep Gangajaliya on 14/06/18.
//  Copyright © 2018 Sandeep Gangajaliya. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol NavigationItemDelegate: NSObjectProtocol {
    @objc optional func itemLeftTaped(sender: UIBarButtonItem)
    @objc optional func itemRightTaped(sender: UIBarButtonItem)
}

class NavigationItem: UINavigationItem {
    // MARK:- Delegate
    
    weak var delegate:NavigationItemDelegate?
    
    var lblNotificationBadges: UILabel?
    
    var itemLeft: NavigationItemType.TypeLeftButton? = .noButton {
        
        didSet {
            if itemLeft != nil {
                setLeftNavigationItem(itemLeft!)
            }
        }
    }
    
    var itemRight: [NavigationItemType.TypeRightButton?] = [.noButton] {
        
        didSet {
            if itemRight.count != 0 {
                setRightNavigationItem(itemRight as! [NavigationItemType.TypeRightButton])
            }
        }
    }
}

// MARK: - Set Left NavigationItem
extension NavigationItem {
    
    func setLeftNavigationItem(_ itemType: NavigationItemType.TypeLeftButton) {
        var arrBtns: [UIBarButtonItem] = []
        switch itemType {
            
        case .btnBack:
            let barBtnLeft = UIBarButtonItem.init(image:UIImage(named: "back_icon"), style: .plain, target: self, action: #selector(btnLeftTaped))
            barBtnLeft.tintColor = .black
            barBtnLeft.accessibilityLabel = ""
            arrBtns.append(barBtnLeft)
            break
            
        case .btnBackWhite:
            let barBtnLeft = UIBarButtonItem.init(image:UIImage(named: "back_icon"), style: .plain, target: self, action: #selector(btnLeftTaped))
            barBtnLeft.tintColor = .white
            barBtnLeft.accessibilityLabel = ""
            arrBtns.append(barBtnLeft)
            break
            
        case .btnBackWithTitle(let value):
            let barBtnLeft = UIBarButtonItem.init(image:UIImage(named: "back_icon"), style: .plain, target: self, action: #selector(btnLeftTaped))
            barBtnLeft.tintColor = .black
            barBtnLeft.accessibilityLabel = ""
            barBtnLeft.title = value
            barBtnLeft.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)], for: .normal)
            arrBtns.append(barBtnLeft)
            break
            
        case .btnWithStringAndColor(let value, let color):
            let barBtnLeft = UIBarButtonItem.init(title: value, style: .plain, target: self, action: #selector(btnLeftTaped))
            barBtnLeft.tintColor = color
            barBtnLeft.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)], for: .normal)
            arrBtns.append(barBtnLeft)
            break
            
        case .btnWithIcon(let image):
            let barBtnLeft = UIBarButtonItem.init(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnLeftTaped))
//            barBtnLeft.tintColor = .appPrimaryColor
            arrBtns.append(barBtnLeft)
            break
        default:
            break
        }
        self.setLeftBarButtonItems(arrBtns, animated: true)
    }
    
    @objc func btnLeftTaped(sender: UIBarButtonItem) {
        self.delegate?.itemLeftTaped!(sender: sender)
    }
}

// MARK: - Set Right NavigationItem
extension NavigationItem {
    func setRightNavigationItem(_ itemType: [NavigationItemType.TypeRightButton]) {
        var arrBtns: [UIBarButtonItem] = []
        for (index, item) in itemType.enumerated() {
            switch item {
                
            case .btnWithIcon(let image):
                let rightBarBtn = UIBarButtonItem.init(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnRightTaped))
//                rightBarBtn.tintColor = UIColor.black
                rightBarBtn.accessibilityLabel = ""
                rightBarBtn.tag = index
                arrBtns.append(rightBarBtn)
                break
                
            case .btnWithTitleAndColor(let title, let color):
                let rightBarBtn = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(btnRightTaped))
                rightBarBtn.tintColor = color
                rightBarBtn.accessibilityLabel = ""
                rightBarBtn.tag = index
                rightBarBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)], for: .normal)
//                rightBarBtn.setTitleTextAttributes([NSAttributedString.Key.font: AppFont.proximaNova.with(weight: .semibold, size: 15)!], for: .normal)
                arrBtns.append(rightBarBtn)
                break
                
            case .cartBtn:
//                let rightBarBtn = UIBarButtonItem.init(image: UIImage(named: "cart_gray_nav"), style: .plain, target: self, action: #selector(btnRightTaped))
//                rightBarBtn.tintColor = UIColor.black
//                rightBarBtn.accessibilityLabel = ""
//                rightBarBtn.tag = index
//                arrBtns.append(rightBarBtn)
                
                let notificationIcon = UIImage(named: "cart_gray_nav")
                let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
                btn.setImage(notificationIcon, for: .normal)
                btn.addTarget(self, action: #selector(btnRightTaped), for: .touchUpInside)
                
                let lblBadge = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 18, height: 18))
                lblBadge.backgroundColor = .appPrimaryColor
                lblBadge.clipsToBounds = true
                lblBadge.layer.cornerRadius = 9
                lblBadge.borderWidth = 2
                lblBadge.borderColor = .white
                lblBadge.textColor = UIColor.white
                lblBadge.font = AppFont.proximaNova.with(weight: .bold, size: 9)
                lblBadge.textAlignment = .center
                btn.addSubview(lblBadge)
                lblBadge.isHidden = true
                lblNotificationBadges = lblBadge
                let rightBarBtn = UIBarButtonItem.init(customView: btn)

                arrBtns.append(rightBarBtn)
                
                break
                
            case .noButton:
                break
            }
        }
        self.setRightBarButtonItems(arrBtns, animated: true)
    }
    
    @objc func btnRightTaped(sender: UIBarButtonItem) {
        self.delegate?.itemRightTaped!(sender: sender)
    }
}

// MARK: - NavigationItem Type
enum NavigationItemType {
    
    enum TypeLeftButton {
        case noButton
        case btnBack
        case btnBackWhite
        case btnBackWithTitle(value: String)
        case btnMenu
        case btnWithStringAndColor(value: String, color: UIColor)
        case btnWithIcon(image: UIImage)
    }
    
    enum TypeRightButton {
        case noButton
        case btnWithIcon(image: UIImage)
        case btnWithTitleAndColor(title: String, color: UIColor)
        case cartBtn
    }
    
    case LeftButton(type: TypeLeftButton)
    case RightButton(type: TypeRightButton)
}


protocol NotificationBadgeCounter {
    func updateNotificationBadges()
}

extension NotificationBadgeCounter where Self: UIViewController {
   
    func updateNotificationBadges() {
        
        let navItem = self.navigationItem as? NavigationItem
        navItem?.lblNotificationBadges?.isHidden = true
//        if let user = AuthorisedUser.shared.user {
//            if user.cart_total != 0 {
//                navItem?.lblNotificationBadges?.isHidden = false
//                navItem?.lblNotificationBadges?.text = "\(user.cart_total)"
//            }
//        }
    }

}
