//
//  CitiesViewModel.swift
//  Assignment-Volvo
//
//  Created by user on 25/08/21.
//

import Foundation

class CitiesViewModel {
    
    let dispatchGroup = DispatchGroup()

    /// read-only object
    var tomorrowWeatherForecast: ConsolidatedWeather? {get {weather}}
    var weather: ConsolidatedWeather?
    
    
    /// Description - responsible to fetch the weather forecast data.
    /// - Parameters:
    ///   - earthId: weoid param.
    ///   - completion: success/failure block .
    func getWeatherForecastOfDate(with earthId: Int, completion: @escaping ( WeatherAPIError?) -> Void) {
        let locationDayUrl = "/api/location/\(earthId)"
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
    
    var locations: [CityLocationData] = []
    
    func getLocations(completion: @escaping () -> ()) {
         let cities: [String] =
               [
                "Gothenburg",
                "Stockholm",
                "Mountain View",
               "London",
                "New York",
                "Berlin"
                ]
        
       let _ = cities.map { city in
            dispatchGroup.enter()
            getLocationDetailsByCityName(cityName: city)
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    private func getLocationDetailsByCityName(cityName: String) {
       let locationSearchUrl = "/api/location/search/?query=\(cityName)".encodedURLString!
       print(locationSearchUrl)
      ServiceManager.shared().startRequest(service: CityLocationDataService(with: locationSearchUrl)) { [weak self] (result) in
          switch(result) {
          case .success(let locationResponse):
            self?.locations.append(contentsOf: locationResponse)
           self?.dispatchGroup.leave()
          case .failure(let error):
           self?.dispatchGroup.leave()
              print(error)
          }
      }
   }
}
