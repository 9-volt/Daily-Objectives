//
//  DetailViewController.swift
//  Daily-Objective
//
//  Created by Dan on 21.07.15.
//  Copyright (c) 2015 9volt. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var objectiveImageView:UIImageView!
    var objectiveImage:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.objectiveImageView.image = UIImage(named: objectiveImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
