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
        centresData.append(Record(id: 1, name: "Brighton Montessori @ Fort",code:"CXZ124", unique_code:"cxz124"))
        centresData.append(Record(id: 1, name: "Brighton Montessori @ Frankel",code:"ASX12E", unique_code:"asx12e"))
        centresData.append(Record(id: 1, name: "Brighton Montessori @ River Valley",code:"QAW324", unique_code:"qaw324"))
        centresData.append(Record(id: 1, name: "Brighton Montessori @ Sunset",code:"DCF214", unique_code:"dcf214"))
        centresData.append(Record(id: 1, name: "Brighton Montessori @ Mountbatten",code:"ZASW21", unique_code:"qyqdk3"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Biopolis",code:"ASXWE2", unique_code:"asxwe2"))
        centresData.append(Record(id: 1, name: "Learning Vision @ NCS",code:"AQWS34", unique_code:"aqws34"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Nanyang Technological University",code:"RFDXC3", unique_code:"q5m7b3"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Vista Point",code:"XSDE21", unique_code:"xsde21"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Novena",code:"ASZQW2", unique_code:"aszqw2"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Changi Airport",code:"FGY4E2", unique_code:"fgy4e2"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Nanyang Polytechnic",code:"AQ1SW2", unique_code:"aq1sw2"))
        centresData.append(Record(id: 1, name: "Learning Vision @ KU Education Hub - The Grassroots' Club",code:"2WSDE3", unique_code:"twxnc7"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Icon",code:"3EDFR4", unique_code:"3edfr4"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Fusionopolis",code:"4RFGT5", unique_code:"4rfgt5"))
        centresData.append(Record(id: 1, name: "Learning Vision @ KK Hospital",code:"5TGHY6", unique_code:"5tghy6"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Tan Tock Seng Hospital",code:"3E4R5T", unique_code:"3e4r5t"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Sunshine Place (SSP)",code:"3E4RFD", unique_code:"3e4rfd"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Changi Business Park",code:"43ERFD", unique_code:"43erfd"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Alpha",code:"234REW", unique_code:"234rew"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Kent Ridge",code:"SDF234", unique_code:"sdf234"))
        centresData.append(Record(id: 1, name: "Pat's Schoolhouse @ Lakeside (LA)",code:"3E4FDC", unique_code:"3e4fdc"))
        centresData.append(Record(id: 1, name: "Pat's Schoolhouse @ Baby Haven (BH)",code:"3EDGT5", unique_code:"3edgt5"))
        centresData.append(Record(id: 1, name: "Pat's Schoolhouse @ Halifax Centre (HA)",code:"2WS3ED", unique_code:"2ws3ed"))
        centresData.append(Record(id: 1, name: "Pat's Schoolhouse @ Serangoon Centre (SE)",code:"12W98I", unique_code:"12w98i"))
        centresData.append(Record(id: 1, name: "Pat's Schoolhouse @ Aroozoo (AZ)",code:"265TR4", unique_code:"265tr4"))
        centresData.append(Record(id: 1, name: "Pat's Schoolhouse @ Katong Centre (KA)",code:"23WEXC", unique_code:"23wexc"))
        centresData.append(Record(id: 1, name: "Pat's Schoolhouse @ Ridgewood Centre (RW)",code:"2WS4RF", unique_code:"2ws4rf"))
        centresData.append(Record(id: 1, name: "Pat's Schoolhouse @ Siglap Centre (SI)",code:"1QA5TG", unique_code:"1qa5tg"))
        centresData.append(Record(id: 1, name: "Pat's Schoolhouse @ Tanglin (TA)",code:"43ERDF", unique_code:"43erdfg"))
        centresData.append(Record(id: 1, name: "Pat's Schoolhouse @ Sembawang (SW)",code:"234FD3", unique_code:"234fd3"))
        centresData.append(Record(id: 1, name: "Pat's Schoolhouse @ Jubilee Park (JP)",code:"17TYU4", unique_code:"17tyu4"))
        centresData.append(Record(id: 1, name: "Pat's Schoolhouse @ Claymore Centre (CL)",code:"CVB45M", unique_code:"cvb45m"))
        centresData.append(Record(id: 1, name: "Pat’s Schoolhouse @ Grassroots (GR)",code:"OS5D04", unique_code:"os5d04"))
        centresData.append(Record(id: 1, name: "Learning Vision @ Paya Lebar",code:"OSTCK5", unique_code:"ostck5"))
        centresData.append(Record(id: 1, name: "Brighton Montessori @ Grassroots Club",code:"KJRGH3", unique_code:"kjrgh3"))
        centresData.append(Record(id: 1, name: "PCF Block 1", code: "AAATR", unique_code:"123456"))
        searchResults = centresData
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

