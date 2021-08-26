//
//  MockNetworkManager.swift
//  Assignment-Volvo
//
//  Created by user on 26/08/21.
//

import Foundation


/// Description:  MockAPIClient class responsible for reading data from JSON file present in application bundle.

class MockNetworkManager:APIServiceType {
    
    func startRequest<T: Service>(service: T, completionHandler: @escaping (Result<T.DecodingType, WeatherAPIError>) -> ())  {
       let jsonFileName = lookupJsonFromService(urlPath: service.requestURL)
        
       if jsonFileName.isEmpty {
            completionHandler(Result.failure(WeatherAPIError.jsonFileNotFound))
            return
        }

        guard let jsonData = loadDataFromJsonFile(fileName: jsonFileName) else {
            completionHandler(Result.failure(WeatherAPIError.jsonFileNotLoading))
            return
        }
        
        do {
            let responseData = try JSONDecoder().decode(T.DecodingType.self, from: jsonData)
            completionHandler(.success(responseData))
           
        } catch let error {
            completionHandler(.failure(WeatherAPIError.jsonDecodeError(error: error)))
        }

    }
}

extension MockNetworkManager {
    

     
    
    /// Description - Responsible to read JSON file from application bundle.
    /// - Parameter fileName: Json file name
    /// - Returns: Json data
    private func loadDataFromJsonFile(fileName: String) -> Data? {
        //Mock data
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }
        
        if let path = Bundle(identifier: "com.comany.VolvoTests.Assignment-Volvo")?.path(forResource: fileName, ofType: "json") {
            return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }
        return nil
    }
    
    
    /// Description - responsible to look for appropriate json file
    /// - Parameter urlPath: url path of file
    /// - Returns: JSON file name
    private func lookupJsonFromService(urlPath: String) -> String {
        if urlPath.contains("/api/location/906057") {
            return "WeatherForecast"
        }
        return "MockJSON"
    }
}
