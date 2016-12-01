//
//  ConvertKelvin.swift
//  WeatherMe
//
//  Created by Thomas Richardson on 10/14/16.
//  Copyright © 2016 Thomas Richardson. All rights reserved.
//

import Foundation


func ConvertKelvinToFarenheit(temp : Double ) -> Double{
    
    let kelvinToFarenheitPreDiv = (temp * (9/5) - 459.67 )
    
    let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDiv/10))
    
    return kelvinToFarenheit
}

func ConvertKelvinToCelcius(temp : Double) -> Double {
    
   return Double(round(temp - 273.15))
    
}

