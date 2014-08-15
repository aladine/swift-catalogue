//
//  ViewController.swift
//  NewRecipe
//
//  Created by Dan Tran on 26/6/14.
//  Copyright (c) 2014 com.appcoda. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore

extension Array {
    func each(callback: T -> ()) {
        for item in self {
            callback(item)
        }
    }
    
    func eachWithIndex(callback: (T, Int) -> ()) {
        var index = 0
        for item in self {
            callback(item, index)
            index += 1
        }
    }
}


class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var table_view: UITableView!
    var centresData = Record[]()
    var searchResults = Record[]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.hidesBottomBarWhenPushed = true
//        updateWeatherInfo()
        readFromFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func readFromFile(){
        var error: NSError?
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("data", ofType: "json")
        let content = NSString.stringWithContentsOfFile(path) as String
  
        var data:NSData! = content.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        let jsonDict : NSDictionary? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? NSDictionary
        if let err = error {
            println("error parsing json")
        }
        if let jsonDictionary = jsonDict {
            println("json parsed successfully")
            let total = jsonDictionary["centres"]!.count
            let json_data = JSONValue(jsonDictionary)
            if json_data{
                for var index = 0; index < total; ++index {
                    var code = json_data["centres"][index]["code"].string
                    var unique_code = json_data["centres"][index]["unique_code"].string
                    if !code{
                        code = ""
                    }
                    if !unique_code{
                        unique_code = "" //json_data["centres"][index]["unique_code"].bool
                    }
                    
                    if let this_code = code{
                        if let this_unique_code = unique_code{
                            centresData.append(Record(
                                id: index,
                                name: json_data["centres"][index]["name"].string!,
                                code:this_code,
                                unique_code:this_unique_code))
                        }
                    }

              
                }
                searchResults = centresData
            }
            

        }
    }
    
    func readFromCode(){
        
    }
    
    func updateWeatherInfo() {
        let manager = AFHTTPRequestOperationManager()
        let url = "https://api.myjson.com/bins/53wd3"
        println(url)
        
//        manager.responseSerializer.acceptableContentTypes = NSSet("text/html")
            //= AFHTTPResponseSerializer.serializer()
        manager.GET(url,
            parameters: [],
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                println("JSON: " + responseObject.description!)
                let desc = responseObject.description
//                var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(responseObject.description as NSData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary!

//                let d: NSMutableDictionary! = responseObject.description as NSMutableDictionary
//                println(jsonResult.count)
//                let jsonDict = NSJSONSerialization.JSONObjectWithData(responseObject.description, options: nil, error: nil) as NSDictionary
//                        println(jsonResult)
//                self.updateUISuccess(responseObject as NSDictionary!)
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
                
//                self.loading.text = "Internet appears down!"
            })
    }
    
    func addEffect() {
        [
            UIBlurEffectStyle.Light,
            UIBlurEffectStyle.Dark,
            UIBlurEffectStyle.ExtraLight
            ].map {
                UIBlurEffect(style: $0)
            }.eachWithIndex { (effect, index) in
                var effectView = UIVisualEffectView(effect: effect)
                
                effectView.frame = CGRectMake(0, CGFloat(50 * index), 320, 50)
                
                self.view.addSubview(effectView)
        }
        
    }
    
     func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        if  self.searchDisplayController.active{
            return searchResults.count
        }else{
            return centresData.count
        }
    }

     func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) ->
        UITableViewCell!{
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "customCell")
//          cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            var record: Record!
            if (tableView == self.searchDisplayController.searchResultsTableView ){
                println("search \(searchResults.count) \(indexPath.row)")
                record = searchResults[indexPath.row]
                
            }else{
                println("not search")
                record = centresData[indexPath.row]
            }

            var detail = record.code + " - " + record.unique_code
            cell.textLabel.text = record.name
            cell.detailTextLabel.text = detail
            
            
            
            return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        println("At row \(indexPath.row)")
        
        var alert: UIAlertView = UIAlertView()
        if (tableView == self.searchDisplayController.searchResultsTableView ){
            alert.message = searchResults[indexPath.row].name
        }else{
            alert.message = centresData[indexPath.row].name        }
        alert.title = "Name"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat{
        return 70.0
    }

    
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (!self.searchDisplayController.active){
            cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
            UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        }
    }
    
    func filterContentForSearchText(searchText:String){
        searchResults = centresData.filter{ $0.name.localizedCaseInsensitiveContainsString("\(searchText)") }
        println(searchResults.count )
    }
    
    func searchDisplayController(controller:UISearchDisplayController,  shouldReloadTableForSearchString searchString: String!) ->Bool{
        println(searchString)
     
        self.filterContentForSearchText(searchString )
//        self.searchDisplayController.searchResultsTableView.reloadData()
        //,scope:self.searchDisplayController.searchBar.scopeButtonTitles[self.searchDisplayController.searchBar.selectedScopeButtonIndex()]
        return true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!){
        // get the table and search bar bounds
//        var tableBounds: CGRect = self.table_view.bounds
//        var searchBarFrame:CGRect  = self.searchDisplayController.searchBar.frame
//        
//        // make sure the search bar stays at the table's original x and y as the content moves
//        self.searchDisplayController.searchBar.frame = CGRectMake(
//            tableBounds.origin.x,
//            tableBounds.origin.y,
//            searchBarFrame.size.width,
//            searchBarFrame.size.height
//        )
    }

    

}

