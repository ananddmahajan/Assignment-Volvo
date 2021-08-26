//
//  ServiceManager.swift
//  Assignment-Volvo
//
//  Created by user on 25/08/21.
//

import Foundation

protocol APIServiceType: AnyObject {
    func startRequest<T: Service>(service: T, completionHandler: @escaping (Result<T.DecodingType, WeatherAPIError>) -> ())
}


/// Description -  Network manager class responsible to fetch data from web server.
final class ServiceManager: APIServiceType {
    
    private static var serviceManager: APIServiceType?
    static private(set) var isAppRunningOnTestMode: Bool = false
    
    static func shared() -> APIServiceType {
        ServiceManager.isAppRunningOnTestMode = ServiceManager.isRunningInTestMode
        if isAppRunningOnTestMode {
            serviceManager = MockNetworkManager()
            return serviceManager!
        } else {
            serviceManager = ServiceManager()
            return serviceManager!
        }
    }
    
    func startRequest<T: Service>(service: T, completionHandler: @escaping (Result<T.DecodingType, WeatherAPIError>) -> ()) {
        do {
            let urlRequest = try service.buildRequest()
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                
                    if let error = error {
                        completionHandler(.failure(WeatherAPIError.networkError(error: error)))
                        return
                    }
                    do {
                        if let jsonData = data {
                            let responseData = try JSONDecoder().decode(T.DecodingType.self, from: jsonData)
                            completionHandler(.success(responseData))
                        } else {
                            completionHandler(.failure(WeatherAPIError.unknownDataError))
                        }
                       
                    } catch let error {
                        completionHandler(.failure(WeatherAPIError.jsonDecodeError(error: error)))
                    }
            }.resume()
        } catch  {
            completionHandler(.failure(WeatherAPIError.badURL))
        }
    }
}

extension ServiceManager {
    
    fileprivate static var isRunningInTestMode: Bool {
        return ProcessInfo.processInfo.environment["XCInjectBundleInto"] != nil
    }
    
}
