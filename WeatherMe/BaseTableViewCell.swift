//
//  BaseTableViewCell.swift
//  WeatherMe
//
//  Created by Thomas Richardson on 10/14/16.
//  Copyright © 2016 Thomas Richardson. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempHighLabel: UILabel!
    @IBOutlet weak var tempLowLabel: UILabel!
    
    func configureCell(_image: String, _day: String, _weather: String, _tempHigh: String, _tempLow: String) {
        
        if cellImage != nil {
            cellImage.image = UIImage(named: _image)
        }
        
        if dayLabel != nil {
            dayLabel.text = _day
        }
        
        if weatherLabel != nil {
            weatherLabel.text = _weather
        }
        
        if tempLowLabel != nil {
            tempLowLabel.text = "\(_tempLow)°"
        }
        
        if tempHighLabel != nil {
            tempHighLabel.text = "\(_tempHigh)°"
        }
        
    }



}
