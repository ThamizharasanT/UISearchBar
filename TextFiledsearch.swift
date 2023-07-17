//
//  SelectYourSchoolVC.swift
//  StudentsApp
//
//  Created by thamizharasan t on 17/07/23.
//

import UIKit


class SelectYourSchoolVC: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var search: UITextField!
    
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var deligate: SelectYourSchool!
    var SchoolDropdownListArr: [SchoolDetails]?
    
    var filteredData: [SchoolDetails]?
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        filteredData = SchoolDropdownListArr
    }
    
    
// MARK: - Textfield Delegates
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        var searchSTR = String()
        if let char = string.cString(using: String.Encoding.utf8) {
            if let str = textField.text{
                let isBackSpace = strcmp(char, "\\b")
                if (isBackSpace == -92) {
                    if str.count > 0{
                        searchSTR = String(str.dropLast())
                    }else{
                        searchSTR = ""
                    }
                }else{
                    searchSTR = "\(str)\(string)"
                }
            }
        }
        
        if searchSTR.count == 0{
            SchoolDropdownListArr = filteredData
        }else{
            SchoolDropdownListArr = filteredData?.filter { $0.name?.lowercased().contains(searchSTR.lowercased()) == true}
        }
        self.tableView.reloadData()
        return true
    }
}
extension SelectYourSchoolVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if SchoolDropdownListArr?.count == 0{
            self.tableView.setEmptyMessage("No school found")
        }else{
            self.tableView.restore()
        }
        
        return SchoolDropdownListArr?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectYourSchoolCell", for: indexPath) as! SelectYourSchoolCell
        cell.labelOutLet.text = SchoolDropdownListArr?[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        deligate.SelectedSchool(name: SchoolDropdownListArr?[indexPath.row].name)
        dismiss(animated: false)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}



class SelectYourSchoolCell: UITableViewCell{
    
    @IBOutlet weak var labelOutLet: UILabel!
}
