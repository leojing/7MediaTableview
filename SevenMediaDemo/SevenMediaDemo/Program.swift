//
//  ProgrammerModel.swift
//  SevenMediaDemo
//
//  Created by JINGLUO on 30/6/17.
//  Copyright © 2017 JINGLUO. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Program: DisplayDataProtocol {
  var programId: Int
  var synopsis: String
  var start_time: String
  var end_time: String
  
  // MARK: comform to DisplayDataProtocol
  var imageUrl: String?
  var title: String?
}

// MARK: - init with json

extension Program {
  
  init?(_ json: JSON) {
    guard let programId = json["id"].int,
      let title = json["title"].string,
      let synopsis = json["synopsis"].string,
      let start_time = json["start_time"].string,
      let end_time = json["end_time"].string,
      let imageUrl = json["imageUrl"].string
      else {
        return nil
    }
    
    self.programId = programId
    self.title = title
    self.synopsis = synopsis
    self.start_time = start_time
    self.end_time = end_time
    self.imageUrl = imageUrl

  }
}

extension Program: Equatable {
  static func ==(lhs: Program, rhs: Program) -> Bool {
    return (lhs.programId == rhs.programId) &&
      (lhs.title == rhs.title) &&
      (lhs.synopsis == rhs.synopsis) &&
      (lhs.start_time == rhs.start_time) &&
      (lhs.end_time == rhs.end_time) &&
      (lhs.imageUrl == rhs.imageUrl)
  }
}
