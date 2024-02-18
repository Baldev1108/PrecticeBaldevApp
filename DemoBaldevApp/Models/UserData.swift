//
//  UserData.swift
//  Doves Tutoring
//
//  Created by Gangajaliya Sandeep on 08/10/20.
//

import UIKit
import ObjectMapper

class UserData: Mappable {
    
    var id = 0
    var first_name = ""
    var last_name = ""
    var name = ""
    var username = ""
    var profile_photo = ""
    var country_code = ""
    var country = ""
    var phone = ""
    var invite_code = ""
    var refrence_code = ""
    var push_notification = 0
    var unread_notification_count = 0
    var phone_verify = false
    var email_verify = false
    var online_status = 0
    var online = ""
    var is_complete_profile = 0
    var app_pin_code = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id                      <- map["id"]
        first_name              <- map["first_name"]
        last_name               <- map["last_name"]
        name                    <- map["name"]
        username                <- map["username"]
        profile_photo           <- map["profile_photo"]
        country_code            <- map["country_code"]
        country                 <- map["country"]
        phone                   <- map["phone"]
        invite_code             <- map["invite_code"]
        refrence_code           <- map["refrence_code"]
        push_notification       <- map["push_notification"]
        phone_verify            <- map["phone_verify"]
        email_verify            <- map["email_verify"]
        online_status           <- map["online_status"]
        online                  <- map["online"]
        is_complete_profile     <- map["is_complete_profile"]
        app_pin_code            <- map["app_pin_code"]
        unread_notification_count <- map["unread_notification_count"]
    }
}
