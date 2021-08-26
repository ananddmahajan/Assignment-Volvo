//
//  CitiesViewModel.swift
//  Assignment-Volvo
//
//  Created by user on 25/08/21.
//

import Foundation

class CitiesViewModel {

    
    /// Description - City objects to display the names on list.
    var citites: [City] = City.cities
    
    
    /// read-only object
    var tomorrowWeatherForecast: ConsolidatedWeather? {get {weather}}
    var weather: ConsolidatedWeather?
    
    
    /// Description - responsible to return locaion selected on tableView.
    /// - Parameter selectedIndex: selected UITable View index
    /// - Returns: city location object
    func getlocationMetaDataForSelectedCity(selectedIndex: Int) -> CityLocationData? {
        return AssignmentAppGlobal.global.cityLocations.first (where: {$0.title == citites[selectedIndex].cityName})
    }
    
    
    /// Description - responsible to fetch the weather forecast data.
    /// - Parameters:
    ///   - earthId: weoid param.
    ///   - completion: success/failure block .
    func getWeatherForecastOfDate(with earthId: Int, completion: @escaping ( WeatherAPIError?) -> Void) {
        let locationDayUrl = "https://www.metaweather.com/api/location/\(earthId)"
        ServiceManager.shared().startRequest(service: CityWeatherMetadataService(with: locationDayUrl)) { [weak self] (result) in
            switch(result) {
            case .success(let forecastData):
                self?.weather = forecastData
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
