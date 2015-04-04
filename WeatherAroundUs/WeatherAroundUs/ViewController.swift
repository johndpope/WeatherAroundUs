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
        
        draggingGesture = UIPanGestureRecognizer(target: self, action: "draggedDetailView:")
        cityDetail.addGestureRecognizer(draggingGesture)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func draggedDetailView(sender: UIPanGestureRecognizer){
    
        var y = sender.translationInView(view).y
        
        // check if the view is fully display
        if sender.view!.frame.origin.y == 0{
            
            
        }else{
            
            if y < 0 {
                println("move")
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

