//
//  Tests_macOS.swift
//  Tests macOS
//
//  Created by Łukasz Dziedzic on 20/08/2021.
//

import XCTest
@testable import MusicScales

class Tests_macOS: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMajorScale() throws {
        let major = try ScaleMode(name: "major", type: .major, intervals: [.majorSecond, .majorSecond, .minorSecond, .majorSecond, .majorSecond, .majorSecond, .minorSecond])
        let minor = try ScaleMode(name: "minor", type: .minor, intervals: [.majorSecond, .minorSecond, .majorSecond, .majorSecond, .minorSecond, .majorSecond, .majorSecond])
        let aMinor = Scale(mode: minor, base: .A)
        let cMajor = Scale(mode: major, base: .C)
        print (aMinor.tones)
        print (cMajor.tones)
        for i in 0...6 {
            let tone = (12*i).tone
        print (tone.name, tone.octave)
            print (tone.number)
        }
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
