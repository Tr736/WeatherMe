//
//  Constants.swift
//  WeatherMe
//
//  Created by Thomas Richardson on 10/13/16.
//  Copyright © 2016 Thomas Richardson. All rights reserved.
//

import Foundation
// 4fada3e39cf94856c86e3600ece42482

// http://api.openweathermap.org/data/2.5/weather?lat=20&lon=20&appid=4fada3e39cf94856c86e3600ece42482

let CURRENT_BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let FORECAST_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let LATITUDE = "lat=\(Location.sharedInstance.latitude!)"
let LONGITUDE = "&lon=\(Location.sharedInstance.longitude!)"
let APP_ID = "&appid="
let API_KEY = "4fada3e39cf94856c86e3600ece42482"

let FORECAST_WEATHER_URL = "\(FORECAST_BASE_URL)\(LATITUDE)\(LONGITUDE)\(APP_ID)\(API_KEY)"
let CURRENT_WEATHER_URL = "\(CURRENT_BASE_URL)\(LATITUDE)\(LONGITUDE)\(APP_ID)\(API_KEY)"


typealias DownloadComplete = () -> ()


let forecastNotification = Notification.Name("forecastComplete")
