//
//  SevenMediaDemoTests.swift
//  SevenMediaDemoTests
//
//  Created by JINGLUO on 30/6/17.
//  Copyright © 2017 JINGLUO. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import SevenMediaDemo

class SevenMediaDemoTests: XCTestCase {
  
    let viewModel = ViewModel()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
    func testParseChannel() {
      let json = [
              "channelId": 1,
              "name": "Channel 1",
              "displayOrder": 1
        ] as [String: Any]

      let channel = Channel(JSON(json))
      XCTAssertNotNil(channel)
      
      XCTAssertEqual(channel?.channelId, 1)
      XCTAssertEqual(channel?.name, "Channel 1")
      XCTAssertEqual(channel?.displayOrder, 1)
    }
    
    func testParseProgram() {
      let json = [
        "id": 1,
        "title": "Program 1",
        "synopsis": "Aliquam erat volutpat. Nam euismod, lacus nec malesuada bibendum, massa lorem dapibus nunc, sit amet viverra turpis dolor non massa.",
        "start_time": "2017-01-05T03:00:00.000Z",
        "end_time": "2017-01-05T04:00:00.000Z",
        "imageUrl": "https://s3-ap-southeast-2.amazonaws.com/swm-ftp-s3/ios/2CF-001_small.jpeg"
        ] as [String: Any]
    
      let program = Program(JSON(json))
      XCTAssertNotNil(program)
      
      XCTAssertEqual(program?.programId, 1)
      XCTAssertEqual(program?.title, "Program 1")
      XCTAssertEqual(program?.synopsis, "Aliquam erat volutpat. Nam euismod, lacus nec malesuada bibendum, massa lorem dapibus nunc, sit amet viverra turpis dolor non massa.")
      XCTAssertEqual(program?.start_time, "2017-01-05T03:00:00.000Z")
      XCTAssertEqual(program?.end_time, "2017-01-05T04:00:00.000Z")
      XCTAssertEqual(program?.imageUrl, "https://s3-ap-southeast-2.amazonaws.com/swm-ftp-s3/ios/2CF-001_small.jpeg")
   
    }
  
    func testGetFileID() {
      var dataType = DataType.channel
      XCTAssertEqual(dataType.fileID(), "channel_list.json")
      dataType = DataType.program(3)
      XCTAssertEqual(dataType.fileID(), "channel_programs_3.json")
      dataType = DataType.program(2)
      XCTAssertEqual(dataType.fileID(), "channel_programs_2.json")
    }
  
    func testParseOrderChannels() {
      let ordered = prepareOrderedChannels()

      viewModel.startFetchDataFor(.channel) { array in
        let programs = array as! [Channel]
        XCTAssertNotNil(programs)
        XCTAssertEqual(programs, ordered)
      }
    }
  
    func testParseOrderProgram() {
      let ordered = prepareOrderedPrograms()
      
      viewModel.startFetchDataFor(.program(3)) { array in
        let programs = array as! [Program]
        XCTAssertNotNil(programs)
        XCTAssertEqual(programs, ordered)
      }
    }
  
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
  
    func prepareOrderedChannels() -> [Channel] {
      let ordered = [
        Channel([
          "channelId": 1,
          "name": "Channel 1",
          "displayOrder": 1
          ])!,
        Channel([
          "channelId": 3,
          "name": "Channel 3",
          "displayOrder": 2
          ])!,
        Channel([
          "channelId": 4,
          "name": "Channel 4",
          "displayOrder": 3
          ])!,
        Channel([
          "channelId": 5,
          "name": "Channel 5",
          "displayOrder": 4
          ])!,
        Channel([
          "channelId": 2,
          "name": "Channel 2",
          "displayOrder": 5
          ])!
      ]
      
      return ordered
    }
    
    func prepareOrderedPrograms() -> [Program] {
      let ordered = [
        Program([
          "id": 3,
          "title": "Program 3",
          "synopsis": "Curabitur suscipit ligula id urna condimentum bibendum. Duis aliquam, risus tincidunt bibendum pharetra, risus quam mattis orci, vitae iaculis sapien metus sit amet erat.",
          "start_time": "2017-01-01T03:00:00.000Z",
          "end_time": "2017-01-01T04:00:00.000Z",
          "imageUrl": "https://s3-ap-southeast-2.amazonaws.com/swm-ftp-s3/ios/2CF3-002_small.jpeg"
          ])!,
        Program([
          "id": 5,
          "title": "Program 5",
          "synopsis": "Donec pulvinar vehicula lacinia. Aenean ut mauris eget justo malesuada suscipit. Donec commodo tortor risus, non rhoncus velit dictum eu.",
          "start_time": "2017-01-01T05:00:00.000Z",
          "end_time": "2017-01-01T06:00:00.000Z",
          "imageUrl": "https://s3-ap-southeast-2.amazonaws.com/swm-ftp-s3/ios/30XDAH1WU-001_small.jpeg"
          ])!,
        Program([
          "id": 7,
          "title": "Program 7",
          "synopsis": "Proin tincidunt luctus ante, ut suscipit quam tincidunt non. Fusce eu dolor sit amet urna hendrerit fermentum. Nulla ac justo eu turpis faucibus mollis vel sed urna.",
          "start_time": "2017-01-01T07:00:00.000Z",
          "end_time": "2017-01-01T08:00:00.000Z",
          "imageUrl": "https://s3-ap-southeast-2.amazonaws.com/swm-ftp-s3/ios/48z7ps8wm_small.jpeg"
          ])!,
        Program([
          "id": 4,
          "title": "Program 4",
          "synopsis": "Mauris hendrerit tempor finibus. Morbi vitae malesuada nisi. Suspendisse in mi elementum, accumsan tellus vitae, cursus dui. Ut in tempor nulla, fringilla placerat ex.",
          "start_time": "2017-01-03T03:00:00.000Z",
          "end_time": "2017-01-03T04:00:00.000Z",
          "imageUrl": "https://s3-ap-southeast-2.amazonaws.com/swm-ftp-s3/ios/2CF3-004_small.jpeg"
          ])!,
        Program([
          "id": 1,
          "title": "Program 1",
          "synopsis": "Aliquam erat volutpat. Nam euismod, lacus nec malesuada bibendum, massa lorem dapibus nunc, sit amet viverra turpis dolor non massa.",
          "start_time": "2017-01-05T03:00:00.000Z",
          "end_time": "2017-01-05T04:00:00.000Z",
          "imageUrl": "https://s3-ap-southeast-2.amazonaws.com/swm-ftp-s3/ios/2CF-001_small.jpeg"
          ])!,
        Program([
          "id": 6,
          "title": "Program 6",
          "synopsis": "Vestibulum porttitor mauris eu ipsum bibendum tristique. Maecenas dignissim est a lectus mollis, a lacinia arcu hendrerit.",
          "start_time": "2017-01-05T05:00:00.000Z",
          "end_time": "2017-01-05T06:00:00.000Z",
          "imageUrl": "https://s3-ap-southeast-2.amazonaws.com/swm-ftp-s3/ios/48ffalu33_small.jpeg"
          ])!,
        Program([
          "id": 2,
          "title": "Program 2",
          "synopsis": "Nullam facilisis lacus nulla, vel aliquet nisi malesuada quis. Proin eget odio velit. Pellentesque gravida euismod iaculis. Proin ac placerat sapien.",
          "start_time": "2017-02-01T03:00:00.000Z",
          "end_time": "2017-02-01T04:00:00.000Z",
          "imageUrl": "https://s3-ap-southeast-2.amazonaws.com/swm-ftp-s3/ios/2CF2-001_small.jpeg"
          ])!
      ]
      
      return ordered
    }
  
}
