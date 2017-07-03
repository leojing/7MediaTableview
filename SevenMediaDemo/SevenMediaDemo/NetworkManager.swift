//
//  NetworkManager.swift
//  PocketBookTask
//
//  Created by JINGLUO on 24/6/17.
//  Copyright © 2017 JINGLUO. All rights reserved.
//

import Foundation
import AFNetworking
import SwiftyJSON

class NetworkManager: NSObject {
  private let baseURLString: String = "https://s3-ap-southeast-2.amazonaws.com/swm-ftp-s3/ios/"
  
  func getDataWithFile(_ fileId: String, completionHandler:@escaping (_ data: JSON?, _ error: Error?) -> Void) {
    let requestURL = baseURLString + fileId
    AFHTTPSessionManager().get(requestURL, parameters: nil, progress: nil, success: { (task, responseObject) in
        guard let json = responseObject else {
          return
        }
        let data = JSON(json)
        completionHandler(data, nil)
    }, failure: { (task, error) in
        completionHandler(nil, error)
    })
  }

}

