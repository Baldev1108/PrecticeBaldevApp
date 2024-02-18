//
//  Webservice.swift
//  MazauInfluencer
//
//  Created by Gangajaliya Sandeep on 25/11/19.
//  Copyright © 2019 Saavaj. All rights reserved.
//

import UIKit
import Alamofire

class Webservice: NSObject {
    
    enum Server {
        case live
        case test
        case developement
       
        var baseUrlString: String {
            switch self {
            case .live:
                return "https://test.com/app/api/"
            case .test:
                return "https://test.com/app/api/"
            case .developement:
                return "https://test.dev/app/api/"
            }
        }
        
        var socketBaseUrlString: String {
            switch self {
            case .live:
                return "https://test.com:3010/"
            case .test:
                return "https://test.com:3010/"
            case .developement:
                return "https://test.dev:3010/"
            }
        }
        
        var webSocketUrlString: String {
            switch self {
            case .live:
                return "ws://666.912.14.250:8070"
            case .test:
                return "ws://888.89.566.196:5070"
            case .developement:
                return "ws://555.89.11.16:3040"
            
            }
        }
    }
    
    // use this variable for switching server for development, testing, and production
    static var server: Server {
        return Server.live
    }
    
    // base url for current server
    static var baseUrl: String {
        return Webservice.server.baseUrlString
    }
    
    // use this varible for getting port value for current server
    static var port: String {
        switch Webservice.server {
        case .developement, .test:
            return ":4007/node/"
        case .live:
            return ":4007/node/"
        }
    }
    
    // API Version
    static let version = "v1/"
    
    // Google Stun URL
    static var googleStunUrl = "stun:stun.l.google.com:19302"
    
    enum Authentication {
        private static let existsInviteCode = Webservice.baseUrl + version + "existsInviteCode"
        private static let phoneExists = Webservice.baseUrl + version + "phoneExists"
        private static let updatePhone = Webservice.baseUrl + version + "updatePhone"
        private static let updateProfile = Webservice.baseUrl + version + "updateProfile"
        private static let updateProfilePic = Webservice.baseUrl + version + "updateProfilePic"
        private static let allowNotificationSet = Webservice.baseUrl + version + "allowNotificationSet"
        private static let logout = Webservice.baseUrl + version + "logout"
        private static let getMyProfile = Webservice.baseUrl + version + "getMyProfile"
        private static let getAllUsers = Webservice.baseUrl + version + "getAllUsers"
        
        static func existsInviteCode(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: existsInviteCode, method: .post, parameter: parameter, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func phoneExists(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: phoneExists, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func updatePhone(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: updatePhone, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func updateProfile(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: updateProfile, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getMyProfile(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getMyProfile, method: .get,parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getAllUsers( completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getAllUsers, method: .get, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func updateProfilePic(parameter: Parameter, multipartFormData: [MultipartFormDataModel], completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: updateProfilePic, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, multipartFormData: multipartFormData, completion: completion)
            APIClient.shared.uploadRequest(with: endpoint)
        }
        
        static func allowNotificationSet(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: allowNotificationSet, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        static func logout(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: logout, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
    }
    
    enum Chat {
        private static let getPendingRequest = Webservice.baseUrl + version + "getPendingRequest"
        private static let getMyConnection = Webservice.baseUrl + version + "getMyConnection"
        private static let chatHistory = Webservice.baseUrl + version + "chatHistory"
        private static let clearChatHistory = Webservice.baseUrl + version + "clearChatHistory"
        private static let getQuickAdd = Webservice.baseUrl + version + "getQuickAdd"
        private static let importContacts = Webservice.baseUrl + version + "importContacts"
        private static let getSentRequest = Webservice.baseUrl + version + "getSentRequest"
        private static let createRequest = Webservice.baseUrl + version + "createRequest"
        private static let joinGroupFromLink = Webservice.baseUrl + version + "joinGroupFromLink"
        
        
        static func getPendingRequest(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getPendingRequest, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getMyConnection(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getMyConnection, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func chatHistory(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: chatHistory, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func clearChatHistory(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: clearChatHistory, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getQuickAdd(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getQuickAdd, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func importContacts(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: importContacts, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getSentRequest(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getSentRequest, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func createRequest(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: createRequest, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func joinGroupFromLink(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: joinGroupFromLink, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
    }
    
    enum User {
        private static let getUserTSCMCount = Webservice.baseUrl + version + "getUserTSCMCount"
        private static let sendConnectionRequest = Webservice.baseUrl + version + "sendConnectionRequest"
        private static let withdrawRequest = Webservice.baseUrl + version + "withdrawRequest"
        private static let connectionRequestAccepReject = Webservice.baseUrl + version + "connectionRequestAccepReject"
        private static let getUpcommingSchedule = Webservice.baseUrl + version + "getUpcommingSchedule"
        private static let getSingleUserChatHistory = Webservice.baseUrl + version + "getSingleUserChatHistory"
        private static let blockConnectionRequest = Webservice.baseUrl + version + "blockConnectionRequest"
        private static let blockUserList = Webservice.baseUrl + version + "blockUserList"
        
        static func getUserTSCMCount(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getUserTSCMCount, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        static func getUpcommingSchedule(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getUpcommingSchedule, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        static func getSingleUserChatHistory(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getSingleUserChatHistory, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func sendConnectionRequest(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: sendConnectionRequest, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func withdrawRequest(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: withdrawRequest, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func blockConnectionRequest(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: blockConnectionRequest, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func connectionRequestAccepReject(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: connectionRequestAccepReject, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        static func blockUserList(completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: blockUserList, method: .get, parameter: Parameter(), authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
    }
    
    enum Schedule {
        private static let getScheduls = Webservice.baseUrl + version + "getScheduls"
        private static let getSchedulType = Webservice.baseUrl + version + "getSchedulType"
        private static let getTimezone = Webservice.baseUrl + version + "getTimezone"
        private static let createSchedul = Webservice.baseUrl + version + "createSchedul"
        private static let getSchedulDetail = Webservice.baseUrl + version + "getSchedulDetail"
        private static let scheduleConfirm = Webservice.baseUrl + version + "scheduleConfirm"
        private static let getReminderTimeSlote = Webservice.baseUrl + version + "getReminderTimeSlote"
        private static let updateReminder = Webservice.baseUrl + version + "updateReminder"
        private static let deleteSchedule = Webservice.baseUrl + version + "deleteSchedule"
        private static let removeSchedule = Webservice.baseUrl + version + "removeSchedule"
        private static let addPeopleToSchedule = Webservice.baseUrl + version + "addPeopleToSchedule"
        private static let updateSchedule = Webservice.baseUrl + version + "updateSchedule"
        private static let updateScheduleNoteLocation = Webservice.baseUrl + version + "updateScheduleNoteLocation"
        private static let removeScheduleMember = Webservice.baseUrl + version + "removeScheduleMember"
        private static let updateChatTopic = Webservice.baseUrl + version + "updateChatTopic"
        
        static func getScheduls(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getScheduls, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getSchedulType(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getSchedulType, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func addPeopleToSchedule(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: addPeopleToSchedule, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func removeScheduleMember(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: removeScheduleMember, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func updateScheduleNoteLocation(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: updateScheduleNoteLocation, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func updateSchedule(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: updateSchedule, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getTimezone(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getTimezone, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func createSchedul(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: createSchedul, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getSchedulDetail(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getSchedulDetail, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func scheduleConfirm(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: scheduleConfirm, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func updateReminder(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: updateReminder, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        
        static func getReminderTimeSlote(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getReminderTimeSlote, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        static func deleteSchedule(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: deleteSchedule, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        static func removeSchedule(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: removeSchedule, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        static func updateChatTopic(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: updateChatTopic, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
    }
    
    enum Plan {
        private static let getMyGroupPlans = Webservice.baseUrl + version + "getMyGroupPlans"
        private static let createGroupPlan = Webservice.baseUrl + version + "createGroupPlan"
        private static let addMemberToGroup = Webservice.baseUrl + version + "addMemberToGroup"
        private static let getGroupDetail = Webservice.baseUrl + version + "getGroupDetail"
        private static let getGroupMembers = Webservice.baseUrl + version + "getGroupMembers"
        private static let getGroupActivity = Webservice.baseUrl + version + "getGroupActivity"
        private static let getGroupActivityDetail = Webservice.baseUrl + version + "getGroupActivityDetail"
        private static let createGroupSchedul = Webservice.baseUrl + version + "createGroupSchedul"
        private static let getGroupScheduls = Webservice.baseUrl + version + "getGroupScheduls"
        private static let leftFromGroup = Webservice.baseUrl + version + "leftFromGroup"
        private static let makeAsAdmin = Webservice.baseUrl + version + "makeAsAdmin"
        private static let removeMemberToGroup = Webservice.baseUrl + version + "removeMemberToGroup"
        private static let updateGroupPlan = Webservice.baseUrl + version + "updateGroupPlan"
        
        static func getMyGroupPlans(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getMyGroupPlans, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func createGroupPlan(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: createGroupPlan, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func removeMemberToGroup(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: removeMemberToGroup, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func addMemberToGroup(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: addMemberToGroup, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func updateGroupPlan(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: updateGroupPlan, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func makeAsAdmin(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: makeAsAdmin, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getGroupDetail(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getGroupDetail, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getGroupMembers(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getGroupMembers, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getGroupActivity(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getGroupActivity, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getGroupActivityDetail(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getGroupActivityDetail, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func createGroupSchedul(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: createGroupSchedul, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getGroupScheduls(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getGroupScheduls, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func leftFromGroup(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: leftFromGroup, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
    }
    
    enum ToDos {
        private static let getTodosGroup = Webservice.baseUrl + version + "getTodosGroup"
        private static let assignTodo = Webservice.baseUrl + version + "assignTodo"
        private static let todoCompleted = Webservice.baseUrl + version + "todoCompleted"
        private static let todoDetail = Webservice.baseUrl + version + "todoDetail"
        private static let reassignTodo = Webservice.baseUrl + version + "reassignTodo"
        private static let deleteTodo = Webservice.baseUrl + version + "deleteTodo"
        private static let viewCompletedTodosGroup = Webservice.baseUrl + version + "viewCompletedTodosGroup"
        private static let addComment = Webservice.baseUrl + version + "addComment"
        
        
        static func getTodosGroup(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getTodosGroup, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func assignTodo(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: assignTodo, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func todoCompleted(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: todoCompleted, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func todoDetail(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: todoDetail, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func reassignTodo(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: reassignTodo, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func deleteTodo(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: deleteTodo, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func viewCompletedTodosGroup(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: viewCompletedTodosGroup, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func addComment(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: addComment, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
    }
   
    enum Notification {
        private static let getNotification = Webservice.baseUrl + version + "getNotification"
        private static let getNotificationClear = Webservice.baseUrl + version + "getNotificationClear"
        private static let readNotification = Webservice.baseUrl + version + "readNotification"
        
        
        
        
        static func getNotification(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getNotification, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        static func getNotificationClear(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getNotificationClear, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        static func readNotification(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: readNotification, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
    }
    
    enum Profile {
        private static let changePhone = Webservice.baseUrl + version + "changePhone"
        private static let setAppPincode = Webservice.baseUrl + version + "setAppPincode"
        
        static func changePhone(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: changePhone, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func setAppPincode(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: setAppPincode, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
    }
    
    enum ChatMessage {
        private static let getMessages = Webservice.baseUrl + version + "getMessages"
        private static let sendMedia = Webservice.baseUrl + version + "sendMedia"
        private static let getSticker = Webservice.baseUrl + version + "getSticker"
        private static let getSingleGroupDetail = Webservice.baseUrl + version + "getSingleGroupDetail"
        private static let callRejectUser = Webservice.baseUrl + version + "callRejectUser"
        private static let onCallProgress = Webservice.baseUrl + version + "onCallProgress"
        private static let deleteMessage = Webservice.baseUrl + version + "deleteMessage"
        private static let getSingleMessage = Webservice.baseUrl + version + "getSingleMessage"
        private static let getMentionGroupMembers = Webservice.baseUrl + version + "getMentionGroupMembers"
        
        static func getMessages(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getMessages, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getMentionGroupMembers(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getMentionGroupMembers, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getSingleMessage(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getSingleMessage, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func deleteMessage(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: deleteMessage, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getSingleGroupDetail(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getSingleGroupDetail, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func callRejectUser(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: callRejectUser, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func onCallProgress(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: onCallProgress, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func sendMedia(parameter: Parameter, multipartFormData: [MultipartFormDataModel], completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: sendMedia, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, multipartFormData: multipartFormData, completion: completion)
            APIClient.shared.uploadRequest(with: endpoint)
        }
        
        static func getSticker(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getSticker, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
    }
    
    enum PersonalTodo {
        private static let personalTodoCreate = Webservice.baseUrl + version + "personalTodoCreate"
        private static let getpersonaltodoList = Webservice.baseUrl + version + "getpersonaltodoList"
        private static let personaltodoCompleted = Webservice.baseUrl + version + "personaltodoCompleted"
        private static let deletepersonaltodo = Webservice.baseUrl + version + "deletepersonaltodo"
        private static let submitReport = Webservice.baseUrl + version + "submitReport"
        private static let deletAccount = Webservice.baseUrl + version + "deleteAccount"
        private static let updatePriority = Webservice.baseUrl + version + "reOrderingTodos"
        
        
        
        static func personalTodoCreate(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: personalTodoCreate, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func getpersonaltodoList(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: getpersonaltodoList, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func personaltodoCompleted(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: personaltodoCompleted, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func deletepersonaltodo(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: deletepersonaltodo, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func updatePriority(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: updatePriority, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func submitReport(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: submitReport, method: .post, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
        
        static func deletAccount(parameter: Parameter, completion: @escaping APIResultBlock) {
            let endpoint = EndPoint(path: deletAccount, method: .get, parameter: parameter, authToken: AuthorisedUser.shared.authToken, completion: completion)
            APIClient.shared.request(with: endpoint)
        }
    }
    
    enum Cancel {
       static func cancelPreviousAPICall(completion:@escaping ()->()) {
            
            let sessionManager = Alamofire.Session.default
            sessionManager.session.getTasksWithCompletionHandler {
                
                dataTasks, uploadTasks, downloadTasks in dataTasks.forEach {
                    $0.cancel()
                };
                uploadTasks.forEach {
                    $0.cancel()
                };
                downloadTasks.forEach {
                    $0.cancel()
                }
                completion()
            }
        }

    }
}
