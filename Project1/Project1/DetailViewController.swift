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
    
    // When the view is loaded, if the selectedImage property exists and thus can be set to
    // constant imageToLoad. It's a name from the array of file names in the case.
    // UIImage is a class to display images. They can take a name and load the correct
    // image from the contents. 
    // imageView is created by dragging the storyboard thing. 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage  // Notice this is a optional: both title and selectedImage.
        
        if let imageToLoad = selectedImage {
            imageView.image  = UIImage(named: imageToLoad)
        }
        // Do any additional setup after loading the view.
    }
    
    // Again, super.blabla makes sure the normal stuff gets executed.
    // viewWillAppear gets called right before this view (DetailView) is loaded.
    // viewDidAppear gets called right before the view is dystored (user taps back)
    // navigationContoller (get), if its there, sets its hidesBarsOnTap (get/set) property
    // to true right before the view is loaded, and false again when destroyed.
    // You don't want that active in the actual table, only the detail/picture.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
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
