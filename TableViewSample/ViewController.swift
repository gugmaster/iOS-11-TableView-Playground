//
//  ViewController.swift
//  TableViewSample
//
//  Created by Stefan Gugarel on 10/08/2017.
//  Copyright © 2017 Stefan Gugarel. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		refreshControl?.backgroundColor = UIColor.red
		
		refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: UIControlEvents.valueChanged)

		self.tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
		
		self.navigationController?.navigationBar.isHidden = true
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return 100
		
	}
	
	
	
	public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell") as! UITableViewCell
		
		cell.backgroundColor = UIColor.green
		
		return cell
		
	}
	
	@objc func refresh(_ sender: UIRefreshControl) {
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			
			
			self.refreshControl?.endRefreshing()
			
			let offset = CGPoint(x: 0, y: -100 + 44)
			
			self.tableView.setContentOffset(offset, animated: true)
			
		}

		
	}
}

