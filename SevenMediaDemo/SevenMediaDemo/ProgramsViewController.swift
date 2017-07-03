//
//  ProgramListViewController.swift
//  SevenMediaDemo
//
//  Created by JINGLUO on 1/7/17.
//  Copyright © 2017 JINGLUO. All rights reserved.
//

import UIKit

class ProgramsViewController: UITableViewController {
  
  fileprivate let viewModel = ViewModel()
  var channelId: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - set up

extension ProgramsViewController {
  fileprivate func setUp() {
    viewModel.dataType = .program(channelId)
    viewModel.startFetchDataFor(viewModel.dataType) { (array) in
      if array.count > 0 {
        DispatchQueue.main.async { self.tableView.reloadData() }
      }
    }
  }
}

// MARK: - UITableViewDataSource

extension ProgramsViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection(tableView , section: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return viewModel.cellInstance(tableView, indexPath: indexPath)
  }
}
