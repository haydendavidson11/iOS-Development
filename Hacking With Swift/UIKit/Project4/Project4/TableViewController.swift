//
//  TableViewController.swift
//  Project4
//
//  Created by Hayden Davidson on 2/9/21.
//

import UIKit

class TableViewController: UITableViewController {

    let websites = ["hackingwithswift.com", "apple.com", "woodandwares.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Websites"
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return websites.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = websites[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "webView") as? ViewController {
            
            vc.selectedWebsite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }

}
