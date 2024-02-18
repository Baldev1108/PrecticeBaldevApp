//
//  ProjectUtilities.swift
//  IDTrack
//
//  Created by Gangajaliya Sandeep on 11/8/17.
//  Copyright © 2017 Gangajaliya Sandeep. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import SwiftMessages
import NVActivityIndicatorView
import Photos

class ProjectUtilities: NSObject {
    
    //MARK:- Change DateForamatter
    class func stringFromDate (date: Date, strFormatter strDateFormatter: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormatter
        
        let convertedDate = dateFormatter.string(from: date)
        
        return convertedDate
    }
    
    class func dateFromString (strDate: String, strFormatter strDateFormatter: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormatter
        
        let convertedDate = dateFormatter.date(from: strDate)
        
        return convertedDate!
    }
    
    class func stringFromDate (date: Date, strFormatter strDateFormatter: String, withTimezone timezone: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormatter
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        
        let convertedDate = dateFormatter.string(from: date)
        
        return convertedDate
    }
    
    class func dateFromString(strDate: String, strFormatter strDateFormatter: String, withTimezone timezone: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormatter
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        let convertedDate = dateFormatter.date(from: strDate)
        
        return convertedDate!
    }
    
    class func dateFromStringSame(strDate: String, strFormatter strDateFormatter: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = strDateFormatter
        let dateFromString = dateFormatter.date(from: strDate)
        return dateFromString!
    }
    class func sortByDate(dateArray: [[String: Any]])-> [[String: Any]] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"// yyyy-MM-dd"
        let dateArray2 = dateArray.sorted(by: {($0["priority"] as! Int) < $1["priority"] as! Int})
        let ready = dateArray2.sorted(by: { dateFormatter.date(from:$0["due_date"] as! String)!.compare(dateFormatter.date(from:$1["due_date"] as! String)!) == .orderedAscending })

        print(ready)
        return ready
    }
    
    class func dateFromStringNew (strDate: String, strFormatter strDateFormatter: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormatter
        
        let convertedDate = dateFormatter.date(from: strDate)
        
        return convertedDate
    }
    
    class func changeDateFormate (strDate: String, strFormatter1 strDateFormatter1: String, strFormatter2 strDateFormatter2: String) -> String {
         let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormatter1
        
        if let date = dateFormatter.date(from: strDate){
            dateFormatter.dateFormat = strDateFormatter2
            return dateFormatter.string(from: date)
        }
        return ""
    }
    class func utcToLocal(strDate: String, strFormatter1 strDateFormatter1: String, strFormatter2 strDateFormatter2: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormatter1
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: strDate) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = strDateFormatter2
        
            return dateFormatter.string(from: date)
        }
        return nil
    }
    class func localToUTC(strDate: String, strFormatter1 strDateFormatter1: String, strFormatter2 strDateFormatter2: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormatter1
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        
        if let date = dateFormatter.date(from: strDate) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = strDateFormatter2
        
            return dateFormatter.string(from: date)
        }
        return nil
    }
    class func timeStampToStringDate (timestamp: Double, dateFormatter: String) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatter
        let strDate = formatter.string(from: date)
        
        return strDate
    }
    
    class func differenceInYearBetween2Date(date1: Date, date2: Date) -> Int {
        
        //date1 = current
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: date2, to: date1)
        return ageComponents.year!
    }
    
    class func dayInterval(dateA: Date, dateB: Date) -> Int {
        
        if let day = Calendar.current.dateComponents([.day], from: dateA, to: dateB).day {
            return day
        }

        return 0
    }
    
    class func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {

            let currentCalendar = Calendar.current

            let dateUtc = Date().localDate()
        
            guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
            guard let end = currentCalendar.ordinality(of: comp, in: .era, for: dateUtc) else { return 0 }

            return start - end
        }
    
    
    
    
    class func timestampToOrdinaryDateFormate(timestamp: Double, formatter strDateFormatter: String) -> String {
        
        let date = Date(timeIntervalSince1970: timestamp)
        
        let calendar = Calendar.current
        let anchorComponents = calendar.dateComponents([.day, .month, .year], from: date)
        
        // Formate
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = strDateFormatter
        let newDate = dateFormate.string(from: date)
        
        var day  = "\(anchorComponents.day!)"
        switch (day) {
        case "1" , "21" , "31":
            day.append("st")
        case "2" , "22":
            day.append("nd")
        case "3" ,"23":
            day.append("rd")
        default:
            day.append("th")
        }
        return day + " " + newDate
    }
    
    class func checkTimezoneIsMine(timezone: String) -> Bool {
        if let identifier = TimeZone.abbreviationDictionary[timezone], identifier == TimeZone.current.identifier {
            return true
        } else {
            return false
        }
    }
    
    class func animatePopupView (viewPopup: UIView){
        viewPopup.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001);
        
        UIView.animate(withDuration: 0.3/1.5, animations: {
            
            viewPopup.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
            
        }) { (finished) in
            
            UIView.animate(withDuration: 0.3/2, animations: {
                viewPopup.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9);
            }, completion: { (finished) in
                
                UIView.animate(withDuration: 0.3/2, animations: {
                    viewPopup.transform = CGAffineTransform.identity;
                })
            })
        }
    }
    
    class func showMessageToast(_ message:String, duration: Double = 3){
        let view = MessageView.viewFromNib(layout: .messageView)
        
        view.configureTheme(.success)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: "", body: message, iconText: "")
        view.configureTheme(backgroundColor: .black, foregroundColor: UIColor.white, iconImage: nil)
        
        var config = SwiftMessages.defaultConfig
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        config.duration = .seconds(seconds: duration)
        if message == "" {
            return
        }
        SwiftMessages.show(config: config, view: view)
    }
    
    class func showAlert(vc:UIViewController, strTitle:String, strMessage:String) {
        let alert = UIAlertController(title: "", message: strMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func showAlertWithCompl(vc:UIViewController, strTitle:String, strMessage:String, completion:@escaping(Bool)->() ) {
        let alert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { actionAlt in
            completion(false)
        }))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { actionAlt in
            completion(true)
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func isValidEmail(_ strEmail: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: strEmail)
    }
    
    
    
    class func timeAgoSinceDate(_ date:Date,currentDate:Date) -> String {
        
        let calendar = Calendar.current
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        
        if (components.year! >= 2) || (components.year! >= 1){
            
            return ProjectUtilities.stringFromDate(date: date, strFormatter: "MMMM dd yyyy") + " at " + ProjectUtilities.stringFromDate(date: date, strFormatter: "hh:mm a")
            
        } else if (components.month! >= 2) || (components.month! >= 1) || (components.weekOfYear! >= 2) || (components.weekOfYear! >= 1) || (components.day! >= 2) {
            
            return ProjectUtilities.stringFromDate(date: date, strFormatter: "MMMM dd") + " at " + ProjectUtilities.stringFromDate(date: date, strFormatter: "hh:mm a")
        } else if (components.day! >= 1){
            return "Yesterday"
        } else if (components.hour! >= 2) {
            return "\(components.hour!) HR"
        } else if (components.hour! >= 1) {
            return "1 HR"
        } else if (components.minute! >= 2) {
            return "\(components.minute!)MINS"
        } else if (components.minute! >= 1) {
            return "1M"
        } else if (components.second! >= 3) {
            return "\(components.second!)S"
        } else {
            return "Just now"
        }
    }
    
    class func secondsToHoursMinutesSeconds (_ seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    class func secondsToDatysHoursMinutesSeconds (_ seconds : Int) -> (Int, Int, Int, Int) {
        
        let days = seconds / 86400
        let hours = (seconds % 86400) / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        
        return (days, hours, minutes, seconds)
    }
    
    class func secondsToMinutesSeconds (_ seconds : Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    class func hexToColor(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    class func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet.init(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    class func setShadow(_ view: UIView) {
        let layer = view.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.4
        layer.masksToBounds = false
    }
    
    class func getSafeAreaTopPadding() -> CGFloat {
        var topPadding: CGFloat = 0
        if #available(iOS 11.0, *) {
            topPadding = (appDelegate.window?.safeAreaInsets.top)!
        }
        return topPadding
    }
    
    class func getSafeAreaBottomPadding() -> CGFloat {
        var bottomPadding: CGFloat = 0
        if #available(iOS 11.0, *) {
            bottomPadding = (appDelegate.window?.safeAreaInsets.bottom)!
        }
        return bottomPadding
    }
    
    class func pushFromBottom(_ navigationController: UINavigationController) {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        navigationController.view.layer.add(transition, forKey: kCATransition)
    }
    
    class func popWithReveal(_ navigationController: UINavigationController) {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController.view.layer.add(transition, forKey: kCATransition)
    }
    
    class func findUniqueSavePathImage() -> String? {
        var path: String
        let df = DateFormatter()
        df.dateFormat = "ddMMyyyhhmmss"
        path = "\(df.string(from: Date())).jpg"
        
        return path
    }
    class func findUniqueSavePathVideo() -> String? {
        var path: String
        let df = DateFormatter()
        df.dateFormat = "ddMMyyyhhmmss"
        path = "\(df.string(from: Date())).mp4"
        
        return path
    }
    class func findUniqueSavePathPDF() -> String? {
        var path: String
        let df = DateFormatter()
        df.dateFormat = "ddMMyyyhhmmss"
        path = "\(df.string(from: Date())).pdf"
        
        return path
    }
    class func findUniqueSavePathM4A() -> String {
        var path: String
        let df = DateFormatter()
        df.dateFormat = "ddMMyyyhhmmss"
        path = "\(df.string(from: Date())).m4a"
        
        return path
    }
    class func findUniqueSavePathDoc() -> String {
        var path: String
        let df = DateFormatter()
        df.dateFormat = "ddMMyyyhhmmss"
        path = "\(df.string(from: Date())).pdf"
        
        return path
    }
    
    class func verifyUrl (_ urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
    
    class func humanReadableByteCount(bytes: Int) -> (Double, String) {
        if (bytes < 1000) { return (Double(bytes), "B") }
        
        let exp = Int(log2(Double(bytes)) / log2(1000.0))
        let unit = ["KB", "MB", "GB", "TB", "PB", "EB"][exp - 1]
        let number = Double(bytes) / pow(1000, Double(exp))
        
        print("Number = ", number, "Unit = ", unit)
        
        return (number, unit)
    }
    
    class func downloadAndSaveMP3(url: URL, name: String, completion:@escaping (URL?, Bool)->()) {
        
        let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
        let destinationFileUrl = documentsUrl.appendingPathComponent(name + ".mp3")
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url: url)
        
        let task =  session.downloadTask(with: request, completionHandler: { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    
                    DispatchQueue.main.async {
                        completion(destinationFileUrl, true)
                    }
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                    
                    DispatchQueue.main.async {
                        completion(nil, false)
                    }
                }
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription ?? "")
                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
        })
        
        task.resume()
    }
    
    class func saveImageToLocal(url: URL, name: String, completion:@escaping (URL?, Bool)->()) {
        DispatchQueue.main.async {
            
            let data = try? Data(contentsOf: url)
            if let data = data, let image = UIImage(data: data) {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                completion(url, true)
            } else {
                completion(nil,false)
            }
        }   
    }
    class func downloadAndSaveImage(url: URL, name: String, completion:@escaping (URL?, Bool)->()) {
        
        let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
        let destinationFileUrl = documentsUrl.appendingPathComponent(name)
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url: url)
        
        let task =  session.downloadTask(with: request, completionHandler: { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    
                    self.saveVideoToAlbum(destinationFileUrl) { error in
                        if let error = error {
                            completion(nil, false)
                        } else {
                            completion(destinationFileUrl, true)
                        }
                    }
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                    
                    DispatchQueue.main.async {
                        completion(nil, false)
                    }
                }
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription ?? "")
                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
        })
        
        task.resume()
    }
    class func downloadAndSaveFiles(url: URL, name: String, completion:@escaping (URL?, Bool)->()) {
        
        let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
        let destinationFileUrl = documentsUrl.appendingPathComponent(name+".mp4")
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url: url)
        
        let task =  session.downloadTask(with: request, completionHandler: { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode), URL:- \(destinationFileUrl)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    
                    self.saveVideoToAlbum(destinationFileUrl) { error in
                        if let error = error {
                            completion(nil, false)
                        } else {
                            completion(destinationFileUrl, true)
                        }
                    }
                   
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                    
                    DispatchQueue.main.async {
                        completion(nil, false)
                    }
                }
                
                
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription ?? "")
                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
        })
        
        task.resume()
    }
    
    class func requestAuthorization(completion: @escaping ()->Void) {
            if PHPhotoLibrary.authorizationStatus() == .notDetermined {
                PHPhotoLibrary.requestAuthorization { (status) in
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            } else if PHPhotoLibrary.authorizationStatus() == .authorized{
                completion()
            }
        }



    class func saveVideoToAlbum(_ outputURL: URL, _ completion: ((Error?) -> Void)?) {
        self.requestAuthorization {
                PHPhotoLibrary.shared().performChanges({
                    let request = PHAssetCreationRequest.forAsset()
                    request.addResource(with: .video, fileURL: outputURL, options: nil)
                }) { (result, error) in
                    DispatchQueue.main.async {
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("Saved successfully")
                        }
                        completion?(error)
                    }
                }
            }
        }
    
    class func findMP3FileInDirectory(name: String) -> (Bool, URL?) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(name + ".mp3") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                print("FILE AVAILABLE")
                return (true, pathComponent)
            } else {
                print("FILE NOT AVAILABLE")
                return (false, nil)
            }
        } else {
            print("FILE PATH NOT AVAILABLE")
            return (false, nil)
        }
    }
    
    class func generateStringFromSecond(totalSecond: Int) -> String {
        let (hours, min, second) = ProjectUtilities.secondsToHoursMinutesSeconds(totalSecond)
        
        var strStartTime = ""
        if totalSecond / 3600 > 0 {
            strStartTime = String(format: "%02d:%02d:%02d", hours, min, second)
        }else if (totalSecond % 3600) / 60 > 0 {
            strStartTime = String(format: "%02d:%02d", min, second)
        }else{
            strStartTime = String(format: "00:%02d",second)
        }
        return strStartTime
    }
    
    class func addYearToDate(date: Date, yearsToAdd: NSInteger) -> Date {
        
        var dateComponent = DateComponents()
        dateComponent.year = yearsToAdd
        
        let addedDate = Calendar.current.date(byAdding: dateComponent, to: date)
        print(addedDate!)
        return addedDate!
    }
    
    class func addDayToDate(date: Date, dayToAdd: NSInteger) -> Date {
        
        var dateComponent = DateComponents()
        dateComponent.day = dayToAdd
        
        let addedDate = Calendar.current.date(byAdding: dateComponent, to: date)
        print(addedDate!)
        return addedDate!
    }
    
    class func numberFormat(number: Double) -> String? {
        let largeNumber = number
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber))
        if formattedNumber != nil {
            return formattedNumber
        } else {
            return nil
        }
    }
    
    class func loadingShow(){
        
        let center = appDelegate.window!.center
        let view = UIView(frame: CGRect(x: center.x - 50, y: center.y - 30, width: 100, height: 60))
        view.tag = 900009
        //view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let activityIndicatorView:NVActivityIndicatorView!
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 60), type: .ballPulse, color: .appPrimaryColor, padding: 5)
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)
        
        appDelegate.window?.addSubview(view)
    }
    
    class func loadingHide(){
        if let view = appDelegate.window?.viewWithTag(900009) {
            view.removeFromSuperview()
        }
    }
    
    class func loadingShow(parentView: UIView, colorForParent: UIColor, dotColor: UIColor? = .appPrimaryColor, frame: CGRect) {
        
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        view.tag = 900009
        view.backgroundColor = colorForParent
        //view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let center = view.center
        let activityIndicatorView:NVActivityIndicatorView!
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: center.x-50, y: center.y-25, width: 100, height: 50), type: .ballPulse, color: dotColor, padding: 5)
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)

        parentView.addSubview(view)
    }
    
    class func loadingHide(parentView: UIView){
        if let view = parentView.viewWithTag(900009) {
            view.removeFromSuperview()
        }
    }
    
    class func setSelectedCornerRadius(view: UIView, corner: UIRectCorner, width: CGFloat, height: CGFloat, layerBg: UIColor) {
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = view.frame
        rectShape.position = view.center
        rectShape.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: width, height: height)).cgPath

        view.layer.backgroundColor = layerBg.cgColor
        view.layer.mask = rectShape
    }
    
    class func getCurrentNavigation() -> UINavigationController? {
        
        if let nav = appDelegate.window?.rootViewController as? UINavigationController {
            return nav
        }
        
        if let tabBar = appDelegate.window?.rootViewController as? UITabBarController {
            if let nav = tabBar.viewControllers?[tabBar.selectedIndex] as? UINavigationController {
                return nav
            }
        }
        
        return nil
    }
    
    class func getThumbnailImage(url: URL, completion: @escaping(UIImage?, Bool) -> Void) {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            completion(UIImage(cgImage: thumbnailImage), true)
        } catch let error {
            print(error)
            completion(nil, false)
        }
    }
    
    class func createVideoThumbnail( url: String?,  completion: @escaping ((_ image: UIImage?)->Void)) {
        
        guard let url = URL(string: url ?? "") else { return }
        DispatchQueue.global().async {
            
            let url = url as URL
            let request = URLRequest(url: url)
            let cache = URLCache.shared
            
            if
                let cachedResponse = cache.cachedResponse(for: request),
                let image = UIImage(data: cachedResponse.data)
            {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            
            let asset = AVAsset(url: url)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            
            var time = asset.duration
            time.value = min(time.value, 2)
            
            var image: UIImage?
            
            do {
                let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
                image = UIImage(cgImage: cgImage)
            } catch { DispatchQueue.main.async {
                completion(nil)
            } }
            
            if
                let image = image,
                let data = image.pngData(),
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                
                cache.storeCachedResponse(cachedResponse, for: request)
                
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
            
        }
        
    }
    class func getThumbnailImage(_ url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    class func encode(_ s: String) -> String {
        let data = s.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
    
    class func decode(_ s: String) -> String? {
        //MARK: - Changed in incomming string for issue with android while incomming message have \\n
        let message = s
        let newString = message.replacingOccurrences(of: "\\n", with: "\n")
        let data = newString.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII)
    }
    class func checkVisibleController() -> UIViewController? {
        if let window = UIApplication.shared.delegate?.window {
            if var viewController = window?.rootViewController {
                // handle navigation controllers
                if(viewController is UINavigationController){
                    viewController = (viewController as! UINavigationController).visibleViewController!
                }
                return viewController
            }
        }
        return nil
    }
    class func stringify(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
          options = JSONSerialization.WritingOptions.prettyPrinted
        }

        do {
          let data = try JSONSerialization.data(withJSONObject: json, options: options)
          if let string = String(data: data, encoding: String.Encoding.utf8) {
            return string
          }
        } catch {
          print(error)
        }

        return ""
    }
    class func jsonParse(jsonString: String)-> [String: Int]? {
        do{
            if let json = jsonString.data(using: String.Encoding.utf8){
                if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:Int]{
                    return jsonData
                }
            }
        }catch {
            print(error.localizedDescription)
            
        }
        return nil
    }
    class func jsonParseArray(jsonString: String)-> [[String: AnyObject]]? {
        do{
            if let json = jsonString.data(using: String.Encoding.utf8){
                if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [[String:AnyObject]]{
                    return jsonData
                }
            }
        }catch {
            print(error.localizedDescription)
            
        }
        return nil
    }
    class func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    class func isUpdateAvailable() throws -> Bool {
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            let identifier = info["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
                return false
        }
        let data = try Data(contentsOf: url)
        guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
            return false
        }
        if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
            print("version in app store", version,currentVersion);
            
            return version != currentVersion
        }
        return false
    }
}



extension Notification.Name {
    static var socketNotConnectedNotification: Notification.Name {
        return Notification.Name("SocketServerNotConnectedNotification")
    }

    static var socketDidConnectedNotification: Notification.Name {
        return Notification.Name("socketDidConnectedNotification")
    }
}
