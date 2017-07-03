//
//  File.swift
//  SevenMediaDemo
//
//  Created by JINGLUO on 30/6/17.
//  Copyright © 2017 JINGLUO. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import SDWebImage

enum DataType {
  case channel
  case program(Int?)
  
  func fileID() -> String {
    switch self {
    case .channel:
      return "channel_list.json"
      
    case .program(let id):
      if let id = id {
        return "channel_programs_\(id).json"
      } else {
        return "channel_programs_.json"
      }
    }
  }
  
  func parseWithJSON(_ json: JSON) -> [DisplayDataProtocol?] {
    switch self {
    case .channel:
      return json["channels"].map({ (_, j) -> Channel? in
        return Channel(j)
      }).sorted(by: { (a, b) -> Bool in
        if let a = a, let b = b {
          return a.displayOrder < b.displayOrder
        }
        return false
      })
      
    case .program:
      return json["programs"].map({ (_, j) -> Program? in
        return Program(j)
      }).sorted(by: { (a, b) -> Bool in
        if let a = a, let b = b {
          return a.start_time < b.start_time
        }
        return false
      })
    }
  }
}

class ViewModel: NSObject {
  
  fileprivate let networkManager = NetworkManager()
  
  fileprivate var dataArray = [DisplayDataProtocol]()
  var dataType: DataType?
  
  // MARK: init
  override init() {
    super.init()
  }
  
  // MARK: fetch data
  func startFetchDataFor(_ dataType: DataType?, completionHandler: ((_ array: [Any]) -> Void)?) {
    if let dataType = dataType {
      networkManager.getDataWithFile(dataType.fileID()) { (data, error) in
        if error != nil {
          print("Error: \(String(describing: error))")
        }
        
        guard let data = data else {
          print("Error: No data")
          return
        }
        
        // filter nil
        self.dataArray = dataType.parseWithJSON(data).filter({ (data) -> Bool in
          return data != nil
        }) as! [DisplayDataProtocol]
        
        if let completionHandler = completionHandler {
          completionHandler(self.dataArray)
        }
      }
    }
  }
  
  // MARK: get data for IndexPath
  func selectRowAt(_ indexPath: IndexPath) -> DisplayDataProtocol {
    return dataArray[indexPath.row]
  }
}

// MARK: - conform to CellRepresentable protocol

extension ViewModel: CellRepresentable {
  
  func numberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
    return dataArray.count
  }
  
  func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "ElementCell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)

    let data = dataArray[indexPath.row]
    cell.textLabel?.text = data.title
    if let imageUrl = data.imageUrl {
      cell.imageView?.sd_setImage(with: URL(string: imageUrl), completed: { (_, _, _, _) in
       cell.setNeedsLayout()
      })
    }
    
    return cell
  }
}
