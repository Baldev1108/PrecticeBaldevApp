//
//  APIClient.swift
//  GAG9APP
//
//  Created by Vikash on 27/11/18.
//  Copyright © 2018 Vikash Kumar. All rights reserved.
//

import Foundation
import Alamofire
import MessageUI


typealias Parameter = [String : Any]
typealias APIResultBlock = (APIClientResult) -> Void
typealias APIRawResultBlock = (APIClientRawResult) -> Void

typealias ResponseBody = [String : Any]

private let ResponseParseErrorMessage = "Sorry! we couldn't parse the server response."

struct APIResponse {
    var statusCode: Int = -1
    var body: ResponseBody?
    var message: String = ""
    
    init() {
        
    }
    
    init(_ json: ResponseBody) {
        var code = 0
        if let status = json["status"] as? Int {
            code = status
        }
        
        var msg = ""
        if let message = json["message"] as? String {
            msg = message
        } else if let error = json["error"] as? String {
            msg = error
        } else if let results = json["Results"] as? [[String: Any]], results.count != 0 {
            
            statusCode = 1
            body = json
            if let msge = json["Message"] as? String {
                message = msge
            }
            
            return
        } else if let _ = json["token"] as? String {
            statusCode = 1
            body = (json as ResponseBody)
            message = msg
            
            return
        } else if let status = json["status"] as? String, status == "OK" {
            statusCode = 1
            body = (json as ResponseBody)
            message = msg
            
            return
        } else {
            return
        }
        
        statusCode = code
        body = (json["body"] as? ResponseBody) ?? json
        message = msg
    }
}

struct APIRawResponse {
    var statusCode: Int = -1
    var tokenStr: String?
    var message: String = ""
    
    init() {
        
    }
    
    init(_ json: ResponseBody) {
        guard let code = json["status"] as? Int else { return }
        
        var msg = ""
        if let message = json["message"] as? String {
            msg = message
        } else if let error = json["error"] as? String {
            msg = error
        } else {
            return
        }
        guard let token = json["cftoken"] as? String else { return }
        
        statusCode = code
        tokenStr = token
        message = msg
    }
}

enum APIClientResult {
    case fail(String)
    case success(APIResponse)
}

enum APIClientRawResult {
    case fail(String)
    case success(APIRawResponse)
}

enum APIClientUploadDownloadResult {
    case fail(Error)
    case success(Any)
    case progress(Float)
}

protocol EndPointProtocol {
    var path: String { get set }
    var method: HTTPMethod  { get set }
    var parameter: Parameter?  { get set }
    var resultCompletion: APIResultBlock?  { get set }
    var resultRawCompletion: APIRawResultBlock?  { get set }
}

class MultipartFormDataModel {
    var name = ""
    var data = Data()
    var mimeType = ""
}

enum AccceptedResultType {
    case raw, statusValidated
}

struct  EndPoint: EndPointProtocol {
    var path: String
    var method: HTTPMethod
    var parameter: Parameter?
    var resultCompletion: APIResultBlock?
    var resultRawCompletion: APIRawResultBlock?
    var authorizedToken: String?
    var showLoader: Bool = true
    var multipartFormData: [MultipartFormDataModel]? = nil
    var headers: HTTPHeaders?
    var encoding: ParameterEncoding = URLEncoding.default
    var isRawData = false
    var isValidateByStatusCode = true
    
    init(path: String, method: HTTPMethod = .get, parameter: Parameter? = nil, authToken: String? = nil, showLoader: Bool = true, encoding: ParameterEncoding = URLEncoding.default, multipartFormData: [MultipartFormDataModel]? = nil,  completion: @escaping APIResultBlock) {
        self.path = path
        self.method = method
        self.parameter = parameter
        self.authorizedToken = authToken
        self.resultCompletion = completion
        self.showLoader = showLoader
        self.multipartFormData = multipartFormData
        self.encoding = encoding
    }
    
    init(path: String, method: HTTPMethod = .get, parameter: Parameter? = nil, authToken: String? = nil, showLoader: Bool = true, multipartFormData: [MultipartFormDataModel]? = nil, headers: HTTPHeaders? = nil, completion: @escaping APIRawResultBlock) {
        self.path = path
        self.method = method
        self.parameter = parameter
        self.authorizedToken = authToken
        self.resultRawCompletion = completion
        self.showLoader = showLoader
        self.multipartFormData = multipartFormData
        self.headers = headers
    }
}


class APIClient: NSObject, MFMailComposeViewControllerDelegate {
    
    static let shared = APIClient()
    
    let session = Alamofire.Session.default
    
    
    
    func request(with endpoint: EndPoint) {
        
        if endpoint.showLoader {
//            ProjectUtilities.loadingShow()
        }
        
        var headers = APIClient.httpsHeaders(with: endpoint.authorizedToken)
        
        if endpoint.isRawData {
            headers["Content-Type"] = "application/json"
        }
        print(endpoint.path, "->", endpoint.parameter ?? "")
        print("token---> ", endpoint.authorizedToken ?? "")
        
        if !Connectivity.isConnectedToInternet {
            endpoint.resultCompletion?(.fail("Please check internet connection"))
            ProjectUtilities.showMessageToast("Please check internet connection")
            return
         }
        
        session.session.configuration.timeoutIntervalForRequest = 30
        
        session.request(endpoint.path, method: endpoint.method,
                        parameters: endpoint.parameter,
                        encoding: endpoint.encoding,
                        headers: headers)
            .responseJSON { (response) in
                                
                switch response.result {
                    case .failure(let error):
                    
                    
                        endpoint.resultCompletion?(.fail(error.localizedDescription))
                    
                        if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                            print(responseString)
                            if (error.localizedDescription != "URLSessionTask failed with error: The network connection was lost."){
                                self.sendEmailToDeveloper(msg: responseString, apiUrl: endpoint.path, params: endpoint.parameter)
                            }
                        } else {
                            ProjectUtilities.showMessageToast("Please check internet connection")
                        }
                    
                case .success(let value):
                        if let json = value as? ResponseBody {
                            let response = APIResponse(json)
                            
                            if endpoint.isValidateByStatusCode {
                                if response.statusCode == 1 {
                                    print(response.body ?? "")
                                    endpoint.resultCompletion?(.success(response))
                                } else {
                                    
                                    print(json)
                                    if let restaurant_name = json["restaurant_name"] as? String, !restaurant_name.isEmpty {
                                        endpoint.resultCompletion?(.success(response))
                                        return
                                    }
                                    
                                    if let code = json["code"] as? Int, code == 12 {
                                        AuthorisedUser.shared.logoutUser()
                                        UIStoryboard.setAuthenticationAsRootView()
                                        return
                                    }
                                    
                                    endpoint.resultCompletion?(.fail(response.message))
                                }
                            } else {
                                print(response.body ?? "")
                                endpoint.resultCompletion?(.success(response))
                            }
                        } else {
                            endpoint.resultCompletion?(.fail(ResponseParseErrorMessage))
                        }
                }
            }
    }
    
    
    func downloadRequest(with endPoint: EndPoint) {
        
    }
    
    func uploadRequest(with endpoint: EndPoint) {
        if endpoint.showLoader {
//            ProjectUtilities.loadingShow()
        }
        
        let headers = APIClient.httpsHeaders(with: endpoint.authorizedToken)
        
        print(endpoint.path, "->", endpoint.parameter ?? "")
        
        if !Connectivity.isConnectedToInternet {
            endpoint.resultCompletion?(.fail("Please check internet connection"))
            ProjectUtilities.showMessageToast("Please check internet connection")
            return
         }
        
        session.upload(multipartFormData: { (multipartFormData) in

            for item in endpoint.multipartFormData! {
                if item.mimeType == "image/jpg" {
                    multipartFormData.append(item.data, withName: item.name, fileName: ProjectUtilities.findUniqueSavePathImage()!, mimeType: item.mimeType)
                } else if item.mimeType == "mp4" {
                    multipartFormData.append(item.data, withName: item.name, fileName: ProjectUtilities.findUniqueSavePathVideo()!, mimeType: item.mimeType)
                } else if item.mimeType == "audio/m4a" {
                    multipartFormData.append(item.data, withName: item.name, fileName: ProjectUtilities.findUniqueSavePathM4A(), mimeType: item.mimeType)
                } else if item.mimeType == "application/pdf" {
                    multipartFormData.append(item.data, withName: item.name, fileName: ProjectUtilities.findUniqueSavePathDoc(), mimeType: item.mimeType)
                }
            }

            for (key, value) in endpoint.parameter! {
                multipartFormData.append(("\(value)").data(using: .utf8)!, withName: key)
            }

        }, to: endpoint.path, headers: headers).uploadProgress(closure: { (progress) in
            
            print("Upload Progress: \(progress.fractionCompleted)")
            
        }) .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let json = value as? ResponseBody {
                    let response = APIResponse(json)

                    if response.statusCode == 1 {
                        print(response.body ?? "")
                        endpoint.resultCompletion?(.success(response))
                    } else {
                        
                        if let code = json["code"] as? Int, code == 12 {
                            AuthorisedUser.shared.logoutUser()
                            UIStoryboard.setAuthenticationAsRootView()
                            return
                        }
                        
                        endpoint.resultCompletion?(.fail(response.message))
                    }
                } else {
                    endpoint.resultCompletion?(.fail(ResponseParseErrorMessage))
                }
                
            case .failure(let error):
                endpoint.resultCompletion?(.fail(error.localizedDescription))

                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                    print(responseString)
                    if (error.localizedDescription != "URLSessionTask failed with error: The network connection was lost."){
                        self.sendEmailToDeveloper(msg: responseString, apiUrl: endpoint.path, params: endpoint.parameter)
                    }
                }
            }
        }
    }
    
    func multipartRequest(with endpoint: EndPoint) {
        
    }
    
    func requestRawData(with endpoint: EndPoint) {
        
        if endpoint.showLoader {
//            ProjectUtilities.loadingShow()
        }
        
//        var headers: HTTPHeaders = [:]
//
//        if let rh = endpoint.headers {
//            headers = rh
//        }
        
        let headers = APIClient.httpsHeaders(with: endpoint.authorizedToken)
        
        print(endpoint.path, "->", endpoint.parameter ?? "")
        
        if !Connectivity.isConnectedToInternet {
            endpoint.resultCompletion?(.fail("Please check internet connection"))
            ProjectUtilities.showMessageToast("Please check internet connection")
            return
         }
        
        session.request(endpoint.path, method: endpoint.method,
                        parameters: endpoint.parameter, encoding: JSONEncoding.default,
                        headers: headers)
            .responseJSON { (response) in
                
//                ProjectUtilities.loadingHide()
                
                switch response.result {
                case .failure(let error):
                    endpoint.resultCompletion?(.fail(error.localizedDescription))
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                        if (error.localizedDescription != "URLSessionTask failed with error: The network connection was lost."){
                            self.sendEmailToDeveloper(msg: responseString, apiUrl: endpoint.path, params: endpoint.parameter)
                        }
                    }
                    
                case .success(let value):
                    if let json = value as? ResponseBody {
                        let response = APIRawResponse(json)
                        
                        if response.statusCode == 1 {
                            print(response.tokenStr ?? "")
                            endpoint.resultRawCompletion?(.success(response))
                        } else {
                            print(json)
                            
                            if let code = json["code"] as? Int, code == 12 {
                                AuthorisedUser.shared.logoutUser()
                                UIStoryboard.setAuthenticationAsRootView()
                                return
                            }
                            
                            endpoint.resultRawCompletion?(.fail(response.message))
                        }
                    } else {
                        endpoint.resultRawCompletion?(.fail(ResponseParseErrorMessage))
                    }
                }
        }
    }
    
    // class methods
    class func httpsHeaders(with token: String?) -> HTTPHeaders {
        var defaultHeaders = AF.session.configuration.headers
        if let token = token {
            
            defaultHeaders["Authorization"] = "Bearer \(token)"
        }
        return defaultHeaders
    }
    
    func sendEmailToDeveloper(msg: String, apiUrl: String, params: [String: Any]?) {
        
        if msg != "" {
            
            var msgbody = msg
        
            msgbody = msgbody + "\n" + apiUrl.toBase64()
            
            if let params = params {
                do {
                    let data = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
                    msgbody = msgbody + "\n" + data.base64EncodedString()
                } catch {
                    print("could not make data")
                }
            }
            
            
            let alert = UIAlertController(title: "Alert", message: "There seem to be some problems with this application. Could you kindly share the reports to support@speakblock.com?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                
                alert.dismiss(animated: true, completion: nil)
                
                let mc: MFMailComposeViewController = MFMailComposeViewController()
                mc.mailComposeDelegate = self
                mc.setSubject("Report Issue")
                mc.setMessageBody(msgbody, isHTML: false)
                mc.setToRecipients(["support@speakblock.com"])

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if let presentedController = appDelegate.window?.rootViewController?.presentedViewController {
                        presentedController.present(mc, animated: true, completion: nil)
                    } else {
                        appDelegate.window?.rootViewController?.present(mc, animated: true, completion: nil)
                    }
                }
            }))
            if let presentedController = appDelegate.window?.rootViewController?.presentedViewController {
                presentedController.present(alert, animated: true, completion: nil)
            } else {
                appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
