//
//  MapView.swift
//  PaperPlane
//
//  Created by Kedan Li on 15/3/1.
//  Copyright (c) 2015年 Yu Wang. All rights reserved.
//

import UIKit

class MapViewForWeather: GMSMapView, GMSMapViewDelegate, LocationManagerDelegate{

    var mapKMRatio:Double = 0
    
    var mapCenter: GMSMarker!
    var currentLocation: CLLocation!
    
    var zoom:Float = 10

    func setup() {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if userDefaults.valueForKey("longitude") != nil{
            var camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(userDefaults.valueForKey("latitude") as Double, longitude: userDefaults.valueForKey("longitude") as Double, zoom: zoom)
            self.camera = camera
            
        }
        
        self.mapType = kGMSTypeNone
        self.setMinZoom(7, maxZoom: 11)
        self.myLocationEnabled = false
        self.delegate = self
        self.mapType = kGMSTypeNone
        
        var layer = CachingTileClass()
        layer.map = self
        UserLocation.delegate = self
        
    }
    
    func gotCurrentLocation(location: CLLocation) {
        if currentLocation == nil{
            self.animateToLocation(location.coordinate)
        }
        currentLocation = location
        // save user location in nsdefault
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setDouble(location.coordinate.longitude, forKey: "longitude")
        userDefaults.setDouble(location.coordinate.latitude, forKey: "latitude")
        userDefaults.synchronize()
        
    }
    
    
    func mapView(mapView: GMSMapView!, willMove gesture: Bool) {
        
        var arr = WeatherMapCalculations.getWeatherAround(self.camera.target, zoom: self.camera.zoom)
        for var index = 0; index < arr.count; index++
        {
            var content = GMSMarker(position: arr[index])
            content.icon = UIImage(named: "rainning")?.resize(CGSizeMake(25, 25))
            content.appearAnimation = kGMSMarkerAnimationPop
            //content.snippet = "sdds"
            content.map = self
        }

    }
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        // move the prebase if in add base mode
        
    }
    
    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {
        
    }
    
    func mapView(mapView: GMSMapView!, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
        var content = GMSMarker(position: coordinate)
        content.icon = UIImage(named: "rainning")?.resize(CGSizeMake(25, 25))
        content.appearAnimation = kGMSMarkerAnimationPop
        //content.snippet = "sdds"
        content.map = self
        
    }

    
    override init(){
        super.init()
        setup()
        // set up map
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
