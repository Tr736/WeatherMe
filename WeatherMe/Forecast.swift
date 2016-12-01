//
//  Forecast.swift
//  WeatherMe
//
//  Created by Thomas Richardson on 10/14/16.
//  Copyright © 2016 Thomas Richardson. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!

    var forecastArray = [Forecast]()
    var date : String {
        if _date == nil {
            _date = ""
            
        }
        
        return _date
    }
    
    var  weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        
        return _highTemp
    }
    
    var lowTemp : String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
 
    

    func downloadForecastData(completed : @escaping DownloadComplete){
        // download forecast weather data for table view
        
        let forecastURL = URL(string: FORECAST_WEATHER_URL)!
        
        Alamofire.request(forecastURL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary <String, AnyObject>
            {
                if let list = dict["list"] as? [Dictionary<String,AnyObject>]
                {
                    
                    for obj in list {
                        
                        
                        let forecast = Forecast(weatherDict: obj)
                        
                        self.forecastArray.append(forecast)
                        
                    }
                }
                
                
            }

            completed()

        }
    }

    init() {
        downloadForecastData {
            print("TOMMY: \(self.forecastArray.count)")
            NotificationCenter.default.post(name: forecastNotification, object: nil)

        }
    }
    init(weatherDict: Dictionary< String, AnyObject>) {
        
        
        if let temp = weatherDict["temp"] as? Dictionary <String, AnyObject> {
            
            if let min =  temp ["min"] as? Double
            {
                self._lowTemp = "\(ConvertKelvinToCelcius(temp: min))"
                
               // print(self._lowTemp)
            }
            
            if let max =  temp ["max"] as? Double
            {
                self._highTemp = "\(ConvertKelvinToCelcius(temp: max))"
            }
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String,AnyObject>] {
            
            
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
        
        
        
    }
    
}

extension Date {
    
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}


