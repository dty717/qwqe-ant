//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by dty on 2018/10/1.
//  Copyright © 2018年 dty. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    func testMealInitializationSucceeds(){
        let zeroRate=Meal.init(name: "R11", rate: -1, photo: nil)
        XCTAssertNil(zeroRate)
        
    }
    func testMealInitializationFails(){
        let zeroRate=Meal.init(name: "11", rate: 0, photo: nil)
        //XCTAssertNil(zeroRate)
        
    }
    
}
