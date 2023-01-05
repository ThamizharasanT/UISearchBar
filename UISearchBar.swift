//
//  Search.swift
//  login
//
//  Created by thamizharasan t on 10/06/22.
//
//pod 'TextFieldEffects'
import UIKit

class Search: UIViewController,UITableViewDataSource, UISearchBarDelegate {
    
         @IBOutlet weak var tableView: UITableView!
         @IBOutlet weak var searchBar: UISearchBar!
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
        "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
        "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
        "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
        "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]

    var filteredData: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = data
    
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        cell.labels.text = filteredData[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
      }
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//            self.searchBar.showsCancelButton = true
//        tableView.reloadData()
//    }
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//            searchBar.showsCancelButton = false
//            searchBar.text = ""
//            searchBar.resignFirstResponder()
//       
//    }
    
    }
class Cell:UITableViewCell{
    @IBOutlet weak var labels: UILabel!
    
}
