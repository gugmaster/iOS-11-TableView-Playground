//
//  ViewController.swift
//  TableViewSample
//
//  Created by Stefan Gugarel on 10/08/2017.
//  Copyright © 2017 Stefan Gugarel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	//let specialOffset: CGFloat = -20
	
	let topInset: CGFloat = 75 //- 20
	
	
	// MARK: - Offsets for toolbar (iPhone)
	
	/// The content offset which hides the toolbar
	fileprivate var offsetToolbarHidden: CGFloat {
		return -tableView.contentInset.top + tableView.tableHeaderView!.bounds.height //- 20
	}
	
	/// The content offset which shows the toolbar
	fileprivate var offsetToolbarShown: CGFloat {
		return -tableView.contentInset.top //- 20
	}
		
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		tableView.refreshControl?.backgroundColor = UIColor.red
		
		tableView.refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: UIControlEvents.valueChanged)

		self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
		
		self.navigationController?.navigationBar.isHidden = true
		
		tableView.refreshControl = UIRefreshControl()
		tableView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	
	@objc func refresh(_ sender: UIRefreshControl) {
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			
			
			self.tableView.refreshControl?.endRefreshing()
			
			let offset = CGPoint(x: 0, y: -self.topInset +  44)
			
			self.tableView.setContentOffset(offset, animated: true)
			
		}

		
	}
}

extension ViewController: UITableViewDataSource {
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return 100
		
	}
	
	
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
		
		cell.backgroundColor = UIColor.green
		
		return cell
		
	}
	
}


extension ViewController: UITableViewDelegate {
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		
		let offset = targetContentOffset.pointee.y
		
		guard scrollView.contentOffset.y < offsetToolbarHidden else {
			
			// If we are way down and scroll up with force we don't show toolbar
			targetContentOffset.pointee.y = max(offset, offsetToolbarHidden)
			return
		}
		
		// If user lifts finger without velocity it scrolls to whatever is closer
		if velocity.y == 0 {
			
			let topDistance = abs(offsetToolbarHidden - tableView.contentOffset.y)
			let bottomDistance = abs(tableView.contentOffset.y - offsetToolbarShown)
			
			if topDistance > bottomDistance {
				targetContentOffset.pointee.y = offsetToolbarShown
			} else {
				targetContentOffset.pointee.y = offsetToolbarHidden
			}
			
			return
		}
		
		// With velocity snap in the direction of the swipe
		if velocity.y > 0  {
			targetContentOffset.pointee.y = offsetToolbarHidden
		} else {
			targetContentOffset.pointee.y = offsetToolbarShown
		}
	}
}

