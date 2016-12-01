//
//  CurrentWeather.swift
//  WeatherMe
//
//  Created by Thomas Richardson on 10/13/16.
//  Copyright © 2016 Thomas Richardson. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    
    private var  _cityName : String!
    private var _date : String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    
    var cityName: String {
        get {
            
            if _cityName == nil {
                _cityName = ""
            }
            return _cityName
        }
        set
        {
            _cityName = newValue
        }
    }
    
    var weatherType : String {
        set {
            _weatherType = newValue
        }
        get {
            if _weatherType == nil {
                _weatherType = ""
            }
            return _weatherType
        }
    }
    
    var currentTemp: Double {
        get {
            
            if _currentTemp == nil {
                _currentTemp = 0.0
            }
            return _currentTemp
        }
        set
        {
            _currentTemp = newValue
        }
    }
    
    var date : String {
        
        get {
            if _date == nil {
                _date = ""
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle  = .long
            dateFormatter.timeStyle = .none
            
            let currentDate = dateFormatter.string(from: Date())
            
            _date = "Today, \(currentDate)"
            
            return _date
        }
        set {
            _date = newValue
        }
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        
        
        
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            
            let result = response.result
            
             if let dict = result.value as? Dictionary <String, AnyObject>
             {
                if let name = dict["name"] as? String {
                    
                    self._cityName = name.capitalized
                    
                    print(self._cityName)
                    
                }
                
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let name = weather[0]["main"] as? String {
                        
                        self._weatherType = name.capitalized
                        print(self._weatherType)
                    }
                    
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let currentTemp = main["temp"] as? Double {
                        
                        self._currentTemp = ConvertKelvinToCelcius(temp: currentTemp)
                    }
                }
            }
            completed()

            
            }
        }
    
}
