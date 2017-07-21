//
//  ViewController.swift
//  Project1
//
//  Created by Machiel van Dorst on 07-07-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//
//  Controls the main view of your app.

import UIKit

// UIViewController is the default screen, which is just a blank page.
// Change to UITableViewController, which is the basic table view. (inherits from UIViewController)
// Properties exist as long as the screen does.
class ViewController: UITableViewController {
    
    // Holds the pictures as a property: an array
    var pictures = [String]()
    
    // Called when the screen is loaded
    override func viewDidLoad() {
        super.viewDidLoad()  // Run default code before your own.
        
        let fm = FileManager.default  // works with the filesystem
        let path = Bundle.main.resourcePath!  // The standard resource path. It's an
        // optional, but we forced unwrap it because we know it's there for sure.
        
        // try! assumes no error will be thrown. If there is one: runtime error.
        // You have to use a try since the method can throw an error. 
        // The filesystem you defined takes the path and returns the contens as an
        // array called items. 
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }
    
    // Returns the number of rows you need in your table: same as the number of pictures.
    // The tableview is the standard UITableView class. The section parameter can be ignored (it's
    // default to one i think) because we have one section: one list of pictures.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // As you can see, you override it again, but a different function of it. 
    // indexPath contains the section and row, we only have one seciton. It will return the current cell.
    // So, this method is called for each cell and returns what needs to happen at that cell
    
    // tableView has a method dequeueReusableCell which recycles cells that drop off when you scroll
    // so that they can be put on the bottom and can be reused again. We specify that cells with 
    // the id Picture are set to constant cell. indexPath is used internally by the method.
    
    // Now, for each cell: if they have a textLabel, set their text to the name of the picture at the
    // row we are at. Return.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    // This code runs when a users tabs on a row, hence the didSelectRowAt.
    // If (let) we came from a story board (which we did, both views are on the main storyboard)
    // run instantiaViewController to move to a new view. The view to load has id "Detail". 
    // Swift thinks is return a UIViewController though (return value of the method) 
    // it can't see the storyboard.
    // So, check if it can be casted as a DetailViewController. id "Detail" is a DetailViewController
    // so this can be done. So it's assigned to vc.
    
    // Next line: set vc.selectedImage property to the picture with the indexPath.row which in this
    // case is a simple index. 
    
    // Finally, tell the navigationController to display the view we build (vc) using the 
    // pushViewController method. Set its animated parameter to true to get the default 
    // slide over animation of iOS. There is no return value. 
    // The navigationController is an optional: is the view inside one? (yes), move along.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Release RAM here that you don't need anymore.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}









