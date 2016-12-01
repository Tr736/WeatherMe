//
//  ViewController.swift
//  WeatherMe
//
//  Created by Thomas Richardson on 10/13/16.
//  Copyright © 2016 Thomas Richardson. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var splashScreen: UIView!
    @IBOutlet weak var splashBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var splashTopConstraint: NSLayoutConstraint!
    
    
    var locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    var currentWeather = CurrentWeather()
    var forecastsArray = [Forecast]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateMainUI), name: forecastNotification, object: nil)

        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
        
      //  print("TOMMY: \(FORECAST_WEATHER_URL)")

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func updateMainUI(){
        
        dateLabel.text = currentWeather.date
        tempLabel.text = "\(currentWeather.currentTemp)°"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
        if self.forecastsArray.count > 0 {
            self.forecastsArray.remove(at: 0)
        }
        
        splashBottomConstraint.constant = self.view.frame.height
        splashTopConstraint.constant = -self.view.frame.height

        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
  

            }) { (complete) in
            
                self.splashScreen.isHidden = true
        }
     
        self.tableView.reloadData()

    }
    
    func configureCell(cell : BaseTableViewCell, indexPath: IndexPath) {
        
        
        cell.configureCell(_image: forecastsArray[indexPath.row].weatherType, _day: forecastsArray[indexPath.row].date, _weather: forecastsArray[indexPath.row].weatherType, _tempHigh: forecastsArray[indexPath.row].highTemp, _tempLow: forecastsArray[indexPath.row].lowTemp)
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        {
            currentLocation = locationManager.location
            
            
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            
            let forecast = Forecast()
            
            currentWeather.downloadWeatherDetails {
                
                
                self.forecastsArray = forecast.forecastArray
                print("TOMMY \(forecast.forecastArray.count)")
                if forecast.forecastArray.count < 1 {
                    self.locationAuthStatus()
                }
                else
                {
                    self.updateMainUI()

                }
                
                
            }
            
        }
        else {
            
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    


}

extension WeatherVC : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastsArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForcastCell", for: indexPath) as! BaseTableViewCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
}

extension WeatherVC: CLLocationManagerDelegate {

    
}

