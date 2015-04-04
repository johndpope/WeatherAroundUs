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
        
        var cityListAppearDragger: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "cityListAppear:")
        cityListAppearDragger.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(cityListAppearDragger)
        
        var cityListDisappearDragger: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "cityListDisappear:")
        self.cityList.addGestureRecognizer(cityListDisappearDragger)
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        cityList.frame.size = CGSizeMake(view.frame.size.width / 2 , cityList.frame.size.height)
        cityList.frame.origin = CGPointMake(-self.view.frame.width, 0)
        
        cityDetailBack.contentSize = CGSizeMake(view.frame.width, cityDetail.frame.height + view.frame.height * 3 / 4)
        cityDetail.frame.origin = CGPointMake(0, self.view.frame.height)
        //cityDetail enters
        cityDetailAppear()
    }
    
    func cityDetailAppear() {
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            self.cityDetail.frame.origin = CGPointMake(0, self.view.frame.height * 3 / 4)
            self.cityDetail.alpha = 1
        })
    }
    
    func cityListAppear(sender: UIScreenEdgePanGestureRecognizer) {
        
        var x = sender.translationInView(view).x
        cityList.frame.origin = CGPointMake(x - cityList.frame.width, 0)

        if cityList.frame.origin.x >= -50 {
            sender.enabled = false
        }
        
        if sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Failed ||
            sender.state == UIGestureRecognizerState.Cancelled {
        
            UIView.animateWithDuration(Double(x / cityList.frame.width * 1), animations: { () -> Void in
                self.cityList.frame.origin = CGPointMake(0, 0)
                }, completion: { (bool) -> Void in
                    sender.enabled = true
            })

        }
    }
    
    func cityListDisappear(sender: UIPanGestureRecognizer) {
        var x = sender.translationInView(cityList).x
        if x < 0 {
            cityList.frame.origin = CGPointMake(x, 0)
            
            if cityList.frame.origin.x <= -cityList.frame.width + 50 {
                sender.enabled = false
            }
            
            if sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Failed ||
                sender.state == UIGestureRecognizerState.Cancelled {
                    
                    UIView.animateWithDuration(Double(-x / cityList.frame.width * 1), animations: { () -> Void in
                        self.cityList.frame.origin = CGPointMake(-self.cityList.frame.width, 0)
                        }, completion: { (bool) -> Void in
                            sender.enabled = true
                    })
                    
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

