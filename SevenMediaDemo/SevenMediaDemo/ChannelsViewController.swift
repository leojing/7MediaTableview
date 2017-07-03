//
//  ViewController.swift
//  SevenMediaDemo
//
//  Created by JINGLUO on 30/6/17.
//  Copyright © 2017 JINGLUO. All rights reserved.
//

import UIKit

class ChannelsViewController: UITableViewController {

  fileprivate enum Constants {
    fileprivate static let showProgramList = "showProgramList"
  }
  
  fileprivate let viewModel = ViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Constants.showProgramList {
      let controller = segue.destination as! ProgramsViewController
      controller.channelId = sender as? Int
    }
  }

}

// MARK: - set up

extension ChannelsViewController {
  
  fileprivate func setUp() {
    
    viewModel.dataType = .channel
    viewModel.startFetchDataFor(viewModel.dataType) { (array) in
      if array.count > 0 {
        DispatchQueue.main.async { self.tableView.reloadData() }
      }
    }
  }
}

// MARK: - UITableViewDataSource

extension ChannelsViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection(tableView , section: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return viewModel.cellInstance(tableView, indexPath: indexPath)
  }
}

// MARK: - UITableViewDelegate

extension ChannelsViewController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let data = viewModel.selectRowAt(indexPath)
    let channel = data as! Channel
    performSegue(withIdentifier: Constants.showProgramList, sender: channel.channelId)
  }
}


