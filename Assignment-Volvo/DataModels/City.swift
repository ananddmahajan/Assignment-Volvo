//
//  City.swift
//  Assignment-Volvo
//
//  Created by user on 25/08/21.
//

import Foundation


/// Description - City data model responsible to display city name on first screen.
struct City: Hashable {
    let id = UUID()
    let cityName: String
}
extension City {
    static let cities: [City] =
           [
            City(cityName: "Gothenburg"),
            City(cityName: "Stockholm"),
            City(cityName: "Mountain View"),
            City(cityName: "London"),
            City(cityName: "New York"),
            City(cityName: "Berlin")
            ]
}


/// Description - data model to store locaiton information.
struct CityLocationData: Decodable, Hashable {
    let title: String
    let earthId: Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case earthId = "woeid"
    }
}


/// Description - weather forecast metadata
struct ConsolidatedWeather: Decodable {
    let weatherForecast: [CityWeatherMetadata]
    let title: String
    
    private enum CodingKeys: String, CodingKey {
        case weatherForecast = "consolidated_weather"
        case title
    }
}

/// Description - weather forecast metadata
struct CityWeatherMetadata: Decodable {
    
    let earthID: Int
    let weatherStateName: String
    let weatherStateAbbr: String
    let windDirectionCompass: String?
    let applicableDate: String
    let minTemp: Double?
    let maxTemp: Double?
    let humidity: Double?
    let visibility: Double?
    let predictability: Double?
    
    private enum CodingKeys: String, CodingKey {
        case earthID = "id"
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case windDirectionCompass = "wind_direction_compass"
        case applicableDate = "applicable_date"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case humidity
        case visibility
        case predictability
    }
}
