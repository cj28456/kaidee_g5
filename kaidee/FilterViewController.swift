//
//  filterViewController.swift
//  kaidee
//
//  Created by g5 on 5/1/2560 BE.
//  Copyright © 2560 G5. All rights reserved.
//

import UIKit
class FilterViewController : UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    
    var shipping = ["Kerry","Thai Post - EMS","Thai Post - Registerd Mail","aCommerce","CJGLs","DHL","FedEx","Line Man","Lalamove","รับด้วยตัวเอง"]
    
    var sort = "asc"
    
    struct userFilter {
        var searchText : String!
        var min: String!
        var max : String!
        var sort : String!
        var shipping : String!
        var main_filter : String!

    }
    
    var callback : ((userFilter) -> Void)?
    var shippingOption : Array<String> = []
    var filter  = "price"
    
    @IBOutlet weak var shippingTableView: UITableView!
    
    @IBOutlet weak var searchText: UITextField!
    
    @IBOutlet weak var minTableField: UITextField!
    
    @IBOutlet weak var maxTableField: UITextField!
    
    @IBOutlet weak var sortPriceSegment: UISegmentedControl!

    @IBOutlet weak var sortRatingSegment: UISegmentedControl!

    
    
    override func viewDidLoad() {
        
        
        sort = "asc"
        shippingTableView.delegate = self
        shippingTableView.dataSource = self
        
        self.hideKeyboardWhenTappedAround()
        
        
        
    }
    
    
    
    @IBAction func segmentPriceSort(sender: AnyObject) {
        
        if(sortPriceSegment.selectedSegmentIndex == 1)
        {
            sort = "asc"
        }
        if(sortPriceSegment.selectedSegmentIndex == 2)
        {
            sort = "desc"
        }
        
        
    }
    @IBAction func segmentRatingSort(_ sender: Any) {
        
        if(sortRatingSegment.selectedSegmentIndex == 1)
        {
            filter = "rating"
        }
        else
        {
            filter  = "price"
        }
    }
    

    
    @IBAction func submitOnTouch(_ sender: Any) {
        
        //call back after dissmiss view
        
        callback?(userFilter.init(searchText: searchText.text!, min: minTableField.text!, max: maxTableField.text!, sort: sort ,shipping:shippingOption.joined(separator:","),main_filter:filter))
        
        self.dismiss(animated: true, completion: {});
        
    }
    
    @IBAction func cancelOnTouch(_ sender: Any)
    {
        
        self.dismiss(animated: true, completion: {});
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return shipping.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shippingCell", for: indexPath)
        
        print("\(shipping[indexPath.row])")
        cell.textLabel?.text = "\(shipping[indexPath.row])"
        cell.selectionStyle = .none
        
        if shippingOption.index(of: "\(indexPath.row+1)") != nil {
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        
        
        return cell
        
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if let index = shippingOption.index(of: "\(indexPath.row+1)") {
            shippingOption.remove(at: index)
        }
        else
        {
            shippingOption.append("\(indexPath.row+1)")
        }
        
        print("select row \(shippingOption)")

        shippingTableView.reloadData()
        
    }
    
    @IBAction func unwindToHome(unwindSegue: UIStoryboardSegue) {
        
        
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
