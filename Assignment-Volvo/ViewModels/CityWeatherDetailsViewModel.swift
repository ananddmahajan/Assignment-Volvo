//
//  CityWeatherDetailsViewModel.swift
//  Assignment-Volvo
//
//  Created by user on 25/08/21.
//

import Foundation

struct CityWeatherDetailsViewModel {
    var consolidatedWeather: ConsolidatedWeather?
    
    
    /// read only object to display weather information on details screen
    var getWeatherDataForDisplay: CityWeatherMetadata? {
        get {
            consolidatedWeather?.weatherForecast.first(where:{ $0.applicableDate == self.tomorrow() })
        }
    }
}

extension CityWeatherDetailsViewModel {
    
    /// function responsible to calculate tomorrow's date.
    /// - Returns: tomorrow's date 
    private func tomorrow()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date())
    }
}
