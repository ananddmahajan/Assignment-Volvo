//
//  AppDelegate+Location.swift
//  Assignment-Volvo
//
//  Created by user on 26/08/21.
//

import Foundation

extension AppDelegate {

    
    /// Description - get location details of 6 mentioned cities.
    func getLocationsOfListedCities() {
        for city in City.cities {
            dispatchGroup.enter()
            getLocationDetailsByCityName(cityName: city.cityName)
        }
        
        dispatchGroup.notify(queue: .main) {
            print("TASK COMPLETED .. \(AssignmentAppGlobal.global.Locations.count)")
        }
    }
    
    /// Description - method responible to download the location on basis of cityname
    /// - Parameter cityName: name of city
     func getLocationDetailsByCityName(cityName: String) {
        let locationSearchUrl = "https://www.metaweather.com/api/location/search/?query=\(cityName)".encodedURLString!
        print(locationSearchUrl)
       ServiceManager.shared().startRequest(service: CityLocationDataService(with: locationSearchUrl)) { [weak self] (result) in
           switch(result) {
           case .success(let locationResponse):
            AssignmentAppGlobal.global.Locations.append(contentsOf: locationResponse)
            self?.dispatchGroup.leave()
           case .failure(let error):
            self?.dispatchGroup.leave()
               print(error)
           }
       }
    }
    
}
