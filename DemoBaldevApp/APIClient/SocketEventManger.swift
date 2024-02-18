//
//  SocketAPIManger.swift
//  DJ Music
//
//  Created by Sandeep Gangajaliya on 10/29/18.
//  Copyright © 2018 Sandeep Gangajaliya. All rights reserved.
//

import UIKit
import ObjectMapper
import SocketIO

class SocketObject {
    static let shared = SocketObject()

    let manager = SocketManager(socketURL: URL(string: Webservice.server.socketBaseUrlString)!, config: [.log(true), .connectParams(["user_id": "\(AuthorisedUser.shared.user?.id ?? 0)", "name": "\(AuthorisedUser.shared.user?.first_name ?? "0")", "token": AuthorisedUser.shared.authToken]), .compress])
    var socket: SocketIOClient!
    
    func connectSocket(completion: @escaping(Bool) -> () ) {
        
        print("Socket connecting... =============")

        self.socket.on(clientEvent: .connect) {data, ack in
            print("Socket connected =============")

            self.socket.removeAllHandlers()
            completion(true)
            NotificationCenter.default.post(name: NSNotification.Name.socketDidConnectedNotification, object: nil)
            self.onDisconnetSocket()
        }
        
        self.socket.on("error") {data, ack in
            self.manager.reconnect()
            print(data)
        }
        
        let socketConnectionStatus = self.socket.status

            switch socketConnectionStatus {
            case SocketIOStatus.connected:
                print("socket connected")
            case SocketIOStatus.connecting:
                print("socket connecting")
            case SocketIOStatus.disconnected:
                print("socket disconnected")
                self.socket.connect()
            case SocketIOStatus.notConnected:
                print("socket not connected")
                self.socket.connect()
            }
    }
        
    func disconnectSocket() {
        if SocketObject.shared.socket == nil {
            return
        }
        self.socket.removeAllHandlers()
        self.socket.disconnect()
        self.socket = nil
        print("Socket disconnected =============")
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
            NotificationCenter.default.post(name: NSNotification.Name("socket_disconnected"), object: nil)
        })
    }
    
    func onDisconnetSocket() {
        
        if self.socket == nil {return}
        
        self.socket.on(clientEvent: .disconnect) {data, ack in
            print("socket diconnected")
            NotificationCenter.default.post(name: NSNotification.Name("socket_disconnected"), object: nil)
        }
    }
    
    func reconnectSocket() {
        self.manager.reconnect()
    }
}

enum SocketEventManger {
    
    enum Chat {
        public static let joinSpeakSnapRoom = "joinSpeakSnapRoom"
        public static let joinRoom = "joinRoom"
        public static let sendSceduleorGroupMessage = "sendSceduleorGroupMessage"
        public static let getScheduleGroupMessage = "getScheduleGroupMessage"
        public static let disconnect = "disconnect"
        
        public static let readreceipts = "readreceipts"
        public static let getOneReadReceipt = "getOneReadReceipt"
        public static let getSnapReadReceipt = "getSnapReadReceipt"
        public static let getALLReadReceipt = "getALLReadReceipt"
        

        // Instant Chat
        public static let joinTopicRoom = "joinTopicRoom"
        public static let getRequestResponse = "getRequestResponse"
        public static let updateChatRequest = "updateChatRequest"
        public static let sendMessage = "sendMessage"
        public static let getMessage = "getMessage"
        public static let socateconnect = "socateconnect"
        public static let speaking = "speaking"
        public static let instantSpeaking = "instantSpeaking"
        public static let typing = "typing"
        public static let instantTyping = "instantTyping"
        public static let getTyping = "getTyping"
        public static let displayTyping = "displayTyping"
        public static let groupTyping = "groupTyping"
        public static let getGroupTyping = "getGroupTyping"
        public static let readUnreadMessage = "readUnreadMessage"
        public static let getAllUser = "getAllUser"
        public static let getInstantAllUser = "getInstantAllUser"
        
        
        //Single chat
        public static let sendMessageSpeakSnap = "sendMessageSpeakSnap"
        public static let getMessageSpeakSnap = "getMessageSpeakSnap"
        public static let readMessageSpeackChat = "readMessageSpeackChat"
        
        
        
        static func joinRoom(params:[String:Any]) {
            SocketObject.shared.socket.emitWithAck(joinRoom, params).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
        
        static func joinSpeakSnapRoom(params:[String:Any]) {
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.emitWithAck(joinSpeakSnapRoom, params).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
        
        static func readreceipts(params:[String:Any]) {
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.emitWithAck(readreceipts, params).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
        
        static func getOneReadReceipt(completion: @escaping(Bool, [Any]) -> () ) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.on(getOneReadReceipt, callback: { (data, ack) in
                completion(true, data)
            })
        }
        
        static func getSnapReadReceipt(completion: @escaping(Bool, [Any]) -> () ) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.on(getSnapReadReceipt, callback: { (data, ack) in
                completion(true, data)
            })
        }
        
        static func getALLReadReceipt(completion: @escaping(Bool, [Any]) -> () ) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.on(getALLReadReceipt, callback: { (data, ack) in
                completion(true, data)
            })
        }
        
        static func sendSceduleorGroupMessage(params:[String:Any]) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.emitWithAck(sendSceduleorGroupMessage, params).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
        
        static func sendMessageSpeakSnap(params:[String:Any]) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.emitWithAck(sendMessageSpeakSnap, params).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
        
        static func getScheduleGroupMessage(completion: @escaping(Bool, [Any]) -> () ) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.on(getScheduleGroupMessage, callback: { (data, ack) in
                completion(true, data)
            })
        }
        
        static func getAllUser(completion: @escaping(Bool, [Any]) -> () ) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.on(getAllUser, callback: { (data, ack) in
//                print("getAllUser...", ack)
                completion(true, data)
            })
        }
        
        static func getInstantAllUser(completion: @escaping(Bool, [Any]) -> () ) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.on(getInstantAllUser, callback: { (data, ack) in
                print("getInstantAllUser...", ack)
                completion(true, data)
            })
        }
        
        static func disconnectRoom() {
            SocketObject.shared.socket.emitWithAck(disconnect, [:]).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
        
        // Instant Chat
        static func joinTopicRoom(params:[String:Any]) {
            var param = params
//            param["name"] = AuthorisedUser.shared.user?.first_name ?? ""
            print("join room called---> ")
            SocketObject.shared.socket.emitWithAck(joinTopicRoom, param).timingOut(after: 0) { (ack) in
                print("join room called done---> ")
                print(ack)
            }
        }
        
        static func joinTopicRoomKilled(params:[String:Any], completion: @escaping(Bool) -> () ) {
            SocketObject.shared.socket.emitWithAck(joinTopicRoom, params).timingOut(after: 0) { (ack) in
                print(ack)
                completion(true)
            }
        }
        
        static func getRequestResponse(completion: @escaping(Bool, [Any]) -> () ) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.on(getRequestResponse, callback: { (data, ack) in
                completion(true, data)
            })
        }
        
        static func updateChatRequest(params:[String:Any]) {
            
            if SocketObject.shared.socket == nil {
                
                return
            }
            print("updateChatRequest ", AuthorisedUser.shared.user!.id)
            SocketObject.shared.socket.emitWithAck(updateChatRequest, params).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
        
        static func sendMessage(params:[String:Any]) {
            
            if SocketObject.shared.socket == nil {
//                SocketObject.shared.reconnectSocket()
                return
            }
            
            SocketObject.shared.socket.emitWithAck(sendMessage, params).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
        
        static func getMessage(completion: @escaping(Bool, [Any]) -> () ) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.on(getMessage, callback: { (data, ack) in
                completion(true, data)
            })
        }
        
        static func socateconnectReconnect(completion: @escaping(Bool, [Any]) -> () ) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.on(socateconnect, callback: { (data, ack) in
                completion(true, data)
            })
        }
        
        static func getMessageSpeakSnap(completion: @escaping(Bool, [Any]) -> () ) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.on(getMessageSpeakSnap, callback: { (data, ack) in
                completion(true, data)
            })
        }
        
        static func speaking(params:[String:Any]) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.emitWithAck(speaking, params).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
        
        static func instantSpeaking(params:[String:Any]) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.emitWithAck(instantSpeaking, params).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
        
        static func typing(params:[String:Any]) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.emitWithAck(instantTyping, params).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
        
        static func getTyping(completion: @escaping(Bool, [Any]) -> () ) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.on(getTyping, callback: { (data, ack) in
                completion(true, data)
            })
        }
        
        static func displayTyping(completion: @escaping(Bool, [Any]) -> () ) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.on(displayTyping, callback: { (data, ack) in
                completion(true, data)
            })
        }
        
        static func groupTyping(params:[String:Any]) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.emitWithAck(groupTyping, params).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
        
        static func getGroupTyping(completion: @escaping(Bool, [Any]) -> () ) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.on(getGroupTyping, callback: { (data, ack) in
                completion(true, data)
            })
        }
        
        static func readUnreadMessage(params:[String:Any]) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.emitWithAck(readUnreadMessage, params).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
        
        static func readMessageSpeackChat(params:[String:Any]) {
            
            if SocketObject.shared.socket == nil {
                return
            }
            
            SocketObject.shared.socket.emitWithAck(readMessageSpeackChat, params).timingOut(after: 0) { (ack) in
                print(ack)
            }
        }
    }
}
