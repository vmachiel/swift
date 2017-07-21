//
//  DetailViewController.swift
//  Project1
//
//  Created by Machiel van Dorst on 17-07-17.
//  Copyright © 2017 vmachiel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // @IBOutlet specifies a link between this property and the storyboard
    // weak makes sure it's not owned in memory by this code, but by the view
    // When the view is unloaded, so is this property.. right? 
    // and it's of type UIImageView
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageToLoad = selectedImage {
            imageView.image  = UIImage(named: imageToLoad)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
