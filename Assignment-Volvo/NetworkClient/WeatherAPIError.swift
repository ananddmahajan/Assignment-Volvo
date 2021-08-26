//
//  WeatherAPIError.swift
//  Assignment-Volvo
//
//  Created by user on 25/08/21.
//

import Foundation

enum WeatherAPIError: Error {
    case badURL
    case unknownDataError
    case jsonDecodeError (error: Error)
    case networkError (error: Error)
    case jsonFileNotFound
    case jsonFileNotLoading
}

extension WeatherAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("Error occured while url construction.", comment: "")
        case .unknownDataError:
            return NSLocalizedString("Unknown data error occured.", comment: "")
        case .jsonDecodeError(let error):
            return NSLocalizedString("JSON error - \(error.localizedDescription)", comment: "")
        case .networkError(let error):
            return NSLocalizedString("Network error - \(error.localizedDescription)", comment: "")
        case .jsonFileNotFound:
            return NSLocalizedString("Unable to find the jsonFileName.", comment: "")
        case .jsonFileNotLoading:
            return NSLocalizedString("Unable to load the json File.", comment: "")
            }
        }
    }

