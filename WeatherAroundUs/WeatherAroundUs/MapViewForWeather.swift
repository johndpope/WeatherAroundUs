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
    
    var zoom:Float = 15

    func setup() {
        var camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(-33.86, longitude: 151.23, zoom:zoom)
        
        self.camera = camera
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
//            self.animateToLocation(location.coordinate)
    }
    
    
    func mapView(mapView: GMSMapView!, willMove gesture: Bool) {
        /*
        if gesture && planeStaticMode{
            // go to the center coordinate
            self.animateToLocation(UserLocation.centerLocation.coordinate)
            println(mapView.camera.zoom)
        }*/
    }
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        // move the prebase if in add base mode
        
    }
    
    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {
        
    }
    
    func mapView(mapView: GMSMapView!, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D) {
        var content = GMSMarker(position: coordinate)
        content.icon = UIImage(named: "lightningAndRain")?.resize(CGSizeMake(25, 25))
        content.appearAnimation = kGMSMarkerAnimationPop
        content.snippet = "sdds"
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
