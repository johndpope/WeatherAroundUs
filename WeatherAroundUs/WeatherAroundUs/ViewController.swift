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
    @IBOutlet var cityList: UIView!

    var draggingGesture: UIScreenEdgePanGestureRecognizer!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var screenSwipeReco: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "screenLeftEdgeSwiped:")
        screenSwipeReco.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(screenSwipeReco)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        cityDetail.frame.size = view.frame.size
        cityDetail.frame.origin = CGPointMake(0, self.view.frame.height * 3 / 4)
        
        cityList.frame.size = CGSizeMake(cityList.frame.size.width / 2 , cityList.frame.size.height)
        cityList.frame.origin = CGPointMake(-self.view.frame.width, 0)
    }
    
    func screenLeftEdgeSwiped(sender: UIScreenEdgePanGestureRecognizer) {
        
        var x = sender.translationInView(view).x
        cityList.frame.origin = CGPointMake(x - cityList.frame.width, 0)

        if cityList.frame.origin.x >= 0 || sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Failed ||
            sender.state == UIGestureRecognizerState.Cancelled {
        
            UIView.animateWithDuration(Double(x / cityList.frame.width * 0.6), animations: { () -> Void in
                self.cityList.frame.origin = CGPointMake(0, 0)
            })

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

