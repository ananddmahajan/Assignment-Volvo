//
//  CityWeatherDetailsViewController.swift
//  Assignment-Volvo
//
//  Created by user on 25/08/21.
//

import UIKit
import SDWebImage

class CityWeatherDetailsViewController: UIViewController {
   
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherthumbnailImage: UIImageView!
    
    var cityWeatherDetailsViewModel = CityWeatherDetailsViewModel()
    
    override func viewDidLoad() {
        configureWeatherForecastView()
    }
}

extension CityWeatherDetailsViewController {
    
    /// Description - responsible to display weather forecast information on details screen.
    private func configureWeatherForecastView() {
            
        guard let minTemp = cityWeatherDetailsViewModel.getWeatherDataForDisplay?.minTemp,
              let maxTemp = cityWeatherDetailsViewModel.getWeatherDataForDisplay?.maxTemp,
              let title = cityWeatherDetailsViewModel.consolidatedWeather?.title,
              let weatherStateAbbr = cityWeatherDetailsViewModel.getWeatherDataForDisplay?.weatherStateAbbr else {
            return
        }
        weatherthumbnailImage.sd_setImage(with: URL(string: "https://www.metaweather.com/static/img/weather/png/64/\(weatherStateAbbr).png"), completed: nil)
        self.navigationItem.title = title
        minTempLabel.text = String(format: "%.0f°C",minTemp)
        maxTempLabel.text = String(format: "%.0f°C",maxTemp)
    }
}
