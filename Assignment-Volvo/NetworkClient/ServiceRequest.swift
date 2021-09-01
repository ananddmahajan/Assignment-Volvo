//
//  ServiceRequest.swift
//  Assignment-Volvo
//
//  Created by user on 25/08/21.
//

import Foundation

struct BaseURL {
    static let baseURL = "https://www.metaweather.com/api/"
}

 protocol Service {
    associatedtype DecodingType: Decodable
    var requestURL: String {get}
    func buildRequest() throws -> URLRequest
}

extension Service {
    
    var URLPath: URL? {
         URL(string: requestURL, relativeTo: URL(string: BaseURL.baseURL))
    }
    
    func buildRequest() throws -> URLRequest {
        guard let url = URLPath else {
            throw WeatherAPIError.badURL
        }
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}

/// Description  -   Structre to provide decoding type and API path.
struct CityLocationDataService: Service {
    
    typealias DecodingType = [CityLocationData]
    var requestURL: String
    
    init(with endPoint: String) {
        requestURL = endPoint
    }
}

/// Description  -   Structre to provide decoding type and API path.
struct CityWeatherMetadataService: Service {
    typealias DecodingType = ConsolidatedWeather
    var requestURL: String
    
    init(with endPoint: String) {
        requestURL = endPoint
    }
}
