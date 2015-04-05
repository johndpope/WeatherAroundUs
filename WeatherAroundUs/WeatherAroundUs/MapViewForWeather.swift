//
//  MapView.swift
//  PaperPlane
//
//  Created by Kedan Li on 15/3/1.
//  Copyright (c) 2015年 Yu Wang. All rights reserved.
//

import UIKit

class MapViewForWeather: GMSMapView, GMSMapViewDelegate, LocationManagerDelegate, WeatherInformationDelegate{

    var mapKMRatio:Double = 0
    
    var mapCenter: GMSMarker!
    
    var currentLocation: CLLocation!
    
    var weather = WeatherInformation()
    
    var weatherIcons = [String: GMSMarker]()
    var searchedArea = [CLLocation]()
    
    var zoom:Float = 11
    
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
        
        weather.delegate = self
        
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
    
    func gotOneNewWeatherData(cityID: String) {
        
        //println(((((weather.citiesAroundDict[cityID] as [String: AnyObject])["city"] as [String: AnyObject]) ["coord"] as [String: AnyObject])["lat"]! as NSString).doubleValue)
        
        let latitude = (((weather.citiesAroundDict[cityID] as [String: AnyObject])["city"] as [String: AnyObject]) ["coord"] as [String: AnyObject])["lat"]! as Double
        let longitude = (((weather.citiesAroundDict[cityID] as [String: AnyObject])["city"] as [String: AnyObject]) ["coord"] as [String: AnyObject])["lon"]! as Double
        
        
        println(latitude)
        println(longitude)
        

        var marker = GMSMarker(position: CLLocationCoordinate2DMake(latitude
        , longitude))
        marker.icon = UIImage(named: "sunrainning")?.resize(CGSizeMake(25, 25))
        marker.appearAnimation = kGMSMarkerAnimationPop
        //content.snippet = "sdds"
        marker.map = self
        
        weatherIcons.updateValue(marker, forKey: cityID)
    }
    
    func removeOneCity(cityID: String){
        weatherIcons[cityID]!.map = nil
        weatherIcons.removeValueForKey(cityID)
    }
    
    func mapView(mapView: GMSMapView!, willMove gesture: Bool) {
        
        
        if gesture {
            
            
            let thisLocation = CLLocation(latitude: self.camera.target.longitude, longitude: self.camera.target.latitude)
            
            let distance = WeatherMapCalculations.getTheDistanceBasedOnZoom(self.camera.zoom)
            
            var shouldSearch = true
            // check if should perform new search
            for location in searchedArea{
                if thisLocation.distanceFromLocation(location) / 1000 < distance * 5 {
                    shouldSearch = false
                }
            }
            
            if shouldSearch{
                // update weather info
                weather.getLocalWeatherInformation(WeatherMapCalculations.getWeatherAround(self.camera.target, zoom: self.camera.zoom))
                
                searchedArea.append(CLLocation(latitude: self.camera.target.longitude, longitude: self.camera.target.latitude))
                
                if searchedArea.count > 5{
                    searchedArea.removeAtIndex(0)
                }
            }
        }

    }
    
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        // move the prebase if in add base mode
        
    }
    
    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {
        //zoom chnaged
        if zoom != self.camera.zoom{
            for city in weather.citiesAround{
                weatherIcons[city]!.map = nil
            }
            weatherIcons.removeAll(keepCapacity: false)
            weather.removeAllCities()
            searchedArea.removeAll(keepCapacity: false)
            zoom = self.camera.zoom
        }
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
