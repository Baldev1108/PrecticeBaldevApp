//
//  Download.swift
//  VideoApp
//
//  Created by Gangajaliya Sandeep on 12/11/18.
//  Copyright © 2018 Gangajaliya Sandeep. All rights reserved.
//

import Foundation

class Download: NSObject {
    var downloadTask: URLSessionDownloadTask?
    
    typealias ProgressBlock = ((Float) -> Void)
    typealias DownloadFinishBlock = ((URL?) -> Void)
    
    var progressBlock: ProgressBlock?
    var downloadFinishBlock: DownloadFinishBlock?
    
    var filenameToSave = "tempname" // name to save downloaded file
    
    var url: URL?
    
    func downloadFrom(url: URL, progress: @escaping ProgressBlock, completion: @escaping DownloadFinishBlock) {
        
        self.url = url
        
        let downloadRequest = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        downloadTask = session.downloadTask(with: downloadRequest)
        downloadTask?.resume()
        self.progressBlock = progress
        self.downloadFinishBlock = completion
    }
}


extension Download: URLSessionDownloadDelegate {
   
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        let ext = url?.pathExtension ?? ""
        let savePath = DocumentDirectoryPath() + "/\(filenameToSave).\(ext)"
        do {
            try FileManager.default.moveItem(atPath: location.path, toPath: savePath)
        } catch let error {
            print(error)
        }
        self.downloadFinishBlock?(URL(fileURLWithPath: savePath))
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        progressBlock?(progress)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print(error)
        self.downloadFinishBlock?(nil)
    }
}


func DocumentDirectoryPath() -> String {
   let docuementDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
    return docuementDirectoryPath
}

func isFileAvailabeAt(path: String) -> Bool {
    let fm = FileManager.default
    return fm.fileExists(atPath: path)
}
