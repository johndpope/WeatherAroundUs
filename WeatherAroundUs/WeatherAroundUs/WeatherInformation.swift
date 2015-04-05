//
//  WeatherInformation.swift
//  WeatherAroundUs
//
//  Created by Kedan Li on 15/4/5.
//  Copyright (c) 2015年 Kedan Li. All rights reserved.
//

import UIKit
import Alamofire

protocol WeatherInformationDelegate: class {
    func gotOneNewWeatherData(cityID: String)
    func removeOneCity(cityID: String)
}

class WeatherInformation: NSObject {
    
    var citiesAroundDict = [String: AnyObject]()
    var citiesAround = [String]()

    let maxCityNum = 30
    
    var delegate : WeatherInformationDelegate?
    
    func getLocalWeatherInformation(locations: [CLLocationCoordinate2D]){
        
        for location in locations {
            
            var req = Alamofire.request(.GET, NSURL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(location.latitude)&lon=\(location.longitude)&cnt=2&mode=json")!).responseJSON { (_, _, JSON, _) in
                
                if JSON != nil {
                    var result = JSON as [String : AnyObject]
                    let id: AnyObject! = (result["city"] as [String : AnyObject]) ["id"]
                    println(id)
                    if self.citiesAroundDict["\(id)"] == nil {
                        self.citiesAroundDict.updateValue(result, forKey: "\(id)")
                        self.citiesAround.append("\(id)")
                        self.delegate?.gotOneNewWeatherData("\(id)")
                        
                        if self.citiesAround.count > self.maxCityNum{
                            self.removeACity()
                        }
                    }

                }
            }
            
        }
        
    }
    
    func removeACity(){
        let id = citiesAround[0]
        citiesAround.removeAtIndex(0)
        citiesAroundDict.removeValueForKey(id)
        self.delegate?.removeOneCity(id)
    }
    
    func removeAllCities(){
        citiesAround.removeAll(keepCapacity: false)
        citiesAroundDict.removeAll(keepCapacity: false)
        
    }
}
/*
Optional({
    city =     {
        coord =         {
            lat = "40.650101";
            lon = "-73.94957700000001";
        };
        country = US;
        id = 5110302;
        name = Brooklyn;
        population = 0;
    };
    cnt = 2;
    cod = 200;
    list =     (
        {
            clouds = 0;
            deg = 238;
            dt = 1428249600;
            humidity = 68;
            pressure = "1033.26";
            speed = "3.21";
            temp =             {
                day = "282.42";
                eve = "284.51";
                max = "284.89";
                min = "281.81";
                morn = "282.42";
                night = "281.81";
            };
            weather =             (
                {
                    description = "sky is clear";
                    icon = 01d;
                    id = 800;
                    main = Clear;
                }
            );
        },
        {
            clouds = 0;
            deg = 225;
            dt = 1428336000;
            humidity = 68;
            pressure = "1036.05";
            speed = "1.7";
            temp =             {
                day = "284.73";
                eve = "288.65";
                max = "288.65";
                min = "278.17";
                morn = "278.17";
                night = "284.86";
            };
            weather =             (
                {
                    description = "sky is clear";
                    icon = 01d;
                    id = 800;
                    main = Clear;
                }
            );
        }
    );
    message = "0.0024";
})

*/
/*
{"cod":"200","message":0.0024,"city":
    {"id":5110302,"name":"Brooklyn","coord":{"lon":-73.949577,"lat":40.650101},"country":"US","population":0},"cnt":2,"list":[{"dt":1428249600,"temp":{"day":282.42,"min":281.81,"max":284.89,"night":281.81,"eve":284.51,"morn":282.42},"pressure":1033.26,"humidity":68,"weather":[{"id":800,"main":"Clear","description":"sky is clear","icon":"01d"}],"speed":3.21,"deg":238,"clouds":0},{"dt":1428336000,"temp":{"day":284.73,"min":278.17,"max":288.65,"night":284.86,"eve":288.65,"morn":278.17},"pressure":1036.05,"humidity":68,"weather":[{"id":800,"main":"Clear","description":"sky is clear","icon":"01d"}],"speed":1.7,"deg":225,"clouds":0}]
}
*/