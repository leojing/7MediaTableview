//
//  ChannelModel.swift
//  SevenMediaDemo
//
//  Created by JINGLUO on 30/6/17.
//  Copyright © 2017 JINGLUO. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Channel: DisplayDataProtocol {
  var channelId: Int
  var name: String
  var displayOrder: Int
  
  // MARK: comform to DisplayDataProtocol
  var imageUrl: String?
  var title: String?
  var subTitle: String?
}

// MARK: - init with json

extension Channel {
  
  init?(_ json: JSON) {
    guard let channelId = json["channelId"].int,
      let name = json["name"].string,
      let displayOrder = json["displayOrder"].int
      else {
        return nil
    }
    
    self.channelId = channelId
    self.name = name
    self.displayOrder = displayOrder
    
    self.imageUrl = nil
    self.title = self.name
    self.subTitle = String(self.displayOrder)
  }
}

extension Channel: Comparable {
  static func ==(lhs: Channel, rhs: Channel) -> Bool {
    return (lhs.channelId == rhs.channelId) &&
    (lhs.displayOrder == rhs.displayOrder) &&
    (lhs.name == rhs.name)
  }
  
  static func <(lhs: Channel, rhs: Channel) -> Bool {
    return lhs.displayOrder < rhs.displayOrder
  }
}




