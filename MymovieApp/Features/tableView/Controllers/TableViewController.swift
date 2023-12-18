//
//  TableViewController.swift
//  MymovieApp
//
//  Created by Katya Miranda on 17/12/23.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
        self.tableView.backgroundColor = UIColor(named: Colors.TableViewBackground.rawValue)
        
    }
    
    // MARK: - Table view data source
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        return cell
    }
    
    private func setTitle(){
        let titleLabel = UILabel()
        titleLabel.text = "Find"
        titleLabel.font =  UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        
        let bottomMargin: CGFloat = 40
        let headerHeight = titleLabel.frame.height + bottomMargin
        let headerWidth = tableView.bounds.width
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: headerWidth, height: headerHeight))
        titleLabel.center = CGPoint(x: headerView.bounds.midX, y: headerView.bounds.midY)
        headerView.addSubview(titleLabel)
        tableView.tableHeaderView = titleLabel
    }
}
