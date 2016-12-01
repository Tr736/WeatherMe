//
//  Location.swift
//  WeatherMe
//
//  Created by Thomas Richardson on 10/14/16.
//  Copyright © 2016 Thomas Richardson. All rights reserved.
//

import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    
    private init(){}
    
    var latitude : Double!
    var longitude: Double!
    
    
    
}
