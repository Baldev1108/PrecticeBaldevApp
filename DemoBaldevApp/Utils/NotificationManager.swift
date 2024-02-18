//
//  NotificationManager.swift
//  FantasyJi
//
//  Created by Gangajaliya Sandeep on 2/12/19.
//  Copyright © 2019 Gangajaliya Sandeep. All rights reserved.
//

import UIKit

class NotificationObserver: NSObject {
    static let shared = NotificationObserver()
    
    let notificationCenter = NotificationCenter.default
    
    static let showMyContestLeague = "showMyContestLeague"
}
