//
//  Assignment_VolvoTests.swift
//  Assignment-VolvoTests
//
//  Created by user on 26/08/21.
//

import XCTest
@testable import Assignment_Volvo

class Assignment_VolvoTests: XCTestCase {
    
    var viewModel: CitiesViewModel!
    var assignmentTestingHelper = AssignmentTestingHelper()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = CitiesViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testWeatherForecastMetadataAPI() {
        let expectation = self.expectation(description: "Weather Forecast API")
        let earthId = 906057
        viewModel.getWeatherForecastOfDate(with: earthId) { _ in
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 15.0) { error in
           XCTAssertNil(error)
        }
    }
}
