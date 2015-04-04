//
//  ViewController.swift
//  WeatherAroundUs
//
//  Created by Kedan Li on 15/2/25.
//  Copyright (c) 2015年 Kedan Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityDetailBack: UIScrollView!
    @IBOutlet var cityDetail: UIView!

    var draggingGesture: UIPanGestureRecognizer!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityDetail.frame.size = view.frame.size
        cityDetail.frame.origin = CGPointMake(0, self.view.frame.height * 3 / 4)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        cityDetail.frame.size = view.frame.size
        cityDetail.frame.origin = CGPointMake(0, self.view.frame.height * 3 / 4)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

