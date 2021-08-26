//
//  AssignmentAppGlobal.swift
//  Assignment-Volvo
//
//  Created by user on 26/08/21.
//

import Foundation

///Description- Singleton class to share location metadata.
class AssignmentAppGlobal {
    
    static let global = AssignmentAppGlobal()
    //read-only property
    var cityLocations: [CityLocationData] {get { Locations }}
    var Locations: [CityLocationData] = []
}
