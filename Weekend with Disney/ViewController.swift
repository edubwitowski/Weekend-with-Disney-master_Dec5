////
////  ViewController.swift
////  Weekend with Disney
////
////  Created by Macbook on 11/1/17.
////  Copyright © 2017 Eric Witowski. All rights reserved.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var viewOneBackButton: UIButton!
//    @IBOutlet weak var viewOneNextButton: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    @IBOutlet weak var viewMe: UIImageView!
//    @IBOutlet weak var readMe: UITextView!
//
//    @IBAction func viewOneBackButton(_ sender: Any) {
//        displayME()
//    }
//    @IBAction func viewOneNextButton(_ sender: Any) {

    


//
//  ViewController.swift
//  Weekend with Disney
//
//  Created by Macbook on 11/1/17.
//  Copyright © 2017 Eric Witowski. All rights reserved.
//

import UIKit
import Foundation




class ViewController: UIViewController {
    
    
    
    var myData = [["picture":  #imageLiteral(resourceName: "<224d6963 6b657922>"), "read": "Mickey Mouse Club House  Mickey and Donald go together to get their hair cut and try to figure out the best way to go when they get to the fork in the road."],["picture": #imageLiteral(resourceName: "<2257696e 6e696520 74686520 506f6f68 22>"), "read": "Winnie the Pooh Adventures to the Market...Winnie and Gang buy ingriedents for Thanksgiving Feast but encounter many troubles"], ["picture": #imageLiteral(resourceName: "<22426f6f 6b206f66 204c6966 6522>"), "read": "The towns people all gather togehter for the Celebration of Christmas and the light of the Tree in the middle of the Town."],["picture": #imageLiteral(resourceName: "<22506869 6e656173 20616e64 20466572 6222>"), "read": "Phineas and Ferb create a Rocketship that will take them around the world and they build it in the back yard."]]
    
    var currentMe: Int = 0
    
    
    //var picture.image = UIImageView.init(picture: UIImage?)
    
    
    //The plist uses this
    @IBOutlet weak var pictureMe: UIImageView!
    @IBOutlet weak var readMe: UITextView!
    
    
    
    
    
    //var Items:[[AnyIndex:String]] = [AnyIndex]
    
    //outletx2
    //@IBOutlet weak var viewOneBackButton: UIButton!
    @IBOutlet weak var viewOneNextButton: UIButton!
    
    //actionx2
    @IBAction func viewOneBackButton(_ sender: Any) {
        currentMe -= 1
        if currentMe < 0 {
            currentMe = myData.count-1;
        }
        displayMe()
    }
    
    @IBAction func viewOneNextButton(_ sender: Any) {
        currentMe += 1
        if currentMe >= 0 {
            currentMe = myData.count + 1
        }
        displayMe()
    }
    
    func displayMe() {
        pictureMe.image = myData[currentMe][pictureMe] as? UIImageView
        readMe.text = myData[currentMe]["read"] as! String
    }
    
    func readPropertyList(){
        
        var format = PropertyListSerialization.PropertyListFormat.XMLFormat_v1_0 //format of the property list
        var plistData:[String:AnyObject] = [:] //our data
        let plistPath:String? = Bundle.mainBundle().pathForResoure("data", ofType: "plist")!
        let plistXML = NSFileProviderManager.defaultManager.contentsAtPath(plistPath!)!
        
        do{
            plistData = try PropertyListSerialization.propertyListWithData(plistXML,options: .MutableContainersAndLeaves,format: &format)
                as! [String:AnyObject]
        }
        catch {
            print("Error reading plist: \(error), format: \(format)")
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Create a PlistFile structure for file named data.plist
        //     let someCollection = PlistFile(name: "data")
        //Mark 1         //    let disneyCollection = PlistFile(name: "disneyTimes"
        // Load the data from the file into an array of optional type [Any]?
        //     let someArray = someCollection.array
        //Mark 2          //     let disneyArray = disneyCollection.array
        // Load the data from the file into an array and cast it as type [[String: String]]?
        //     let someArray = someCollection.array as? [[String: String]]
        //Mark3      //   let disneyArray = disneyCollection.array as? [[String: String]]
        // Load the data from the file into a dictionary of optional type [String: Any]?
        //     let someArray = someCollection.dictionary
        //mark4    //      let disneyArray = disneyCollection.dictionary
        // Load the data from the file into a dictionary and cast it as optional type [String: String]?
        //     let someArray = someCollection.dictionary as? [String: String]
        //mark5     //     let disneyArray = disneyCollection *********************************************************************************************
        
        
        
        struct PlistFile {
            // stored property with property observer
            var name: String {
                didSet {
                    self.name = removeExt(oldValue)
                }
            }
            // computed properties
            var dictionary: [String: Any]? {
                get {
                    return getDictionary()
                }
            }
            var array: [Any]? {
                get {
                    return getArray()
                }
            }
            private var path: URL? {
                get {
                    return Bundle.main.url(forResource: self.name, withExtension: "plist")
                }
            }
            // this function returns the string removing the suffix .plist, if found
            private func removeExt(_ str: String) -> String {
                if str.hasSuffix(".plist") {
                    #if swift(>=3.2)
                        return String(str[..<str.index(str.endIndex, offsetBy: -6)])
                    #else
                        return str.substring(to: str.index(str.endIndex, offsetBy: -6))
                    #endif
                } else {
                    return str
                }
            }
            // attempts to return the data from the plist as a dictionary
            private func getDictionary() -> [String: Any]? {
                if let result = try? Data(contentsOf: self.path!) {
                    return try! PropertyListSerialization.propertyList(from: result, options: [], format: nil) as? [String: Any]
                } else {
                    return nil
                }
            }
            // attempts to return the data from the plist as an array
            private func getArray() -> [Any]? {
                if let result = try? Data(contentsOf: self.path!) {
                    return try! PropertyListSerialization.propertyList(from: result, options: [], format: nil) as? [Any]
                } else {
                    return nil
                }
            }
            
            init(name fname: String) {
                self.name = fname               // have to initialize the name first
                self.name = removeExt(fname)    // before we can change the value
            }
        }
        
        
        
        print("")
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    if let path = Bundle.main(forResoure: "disneyTimes", ofType: "plist") {
        if let array = NSArray(contentsOfFile: path) as? [String: Any] {
        }
        
        
        //
        //        for Item in Items{
        //            print(Item)
        displayMe()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}












