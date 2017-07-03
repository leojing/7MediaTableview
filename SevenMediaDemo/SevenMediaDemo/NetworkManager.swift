//
//  NetworkManager.swift
//  PocketBookTask
//
//  Created by JINGLUO on 24/6/17.
//  Copyright © 2017 JINGLUO. All rights reserved.
//

import Foundation
import SwiftyJSON

class NetworkManager: NSObject {
  private let baseURLString: String = "https://s3-ap-southeast-2.amazonaws.com/swm-ftp-s3/ios/"
  
  func getDataWithFile(_ fileId: String, completionHandler:@escaping (_ data: JSON?, _ error: Error?) -> Void) {
    let requestURL = baseURLString + fileId
    let task = URLSession.shared.dataTask(with: URL(string: requestURL)!) { (data, response, error) in
      if let error = error {
        completionHandler(nil, error)
        return
      }
      
      guard let data = data else {
        completionHandler(nil, nil)
        return
      }
      completionHandler(JSON(data: data), nil)
    }
    task.resume()
  }

}

