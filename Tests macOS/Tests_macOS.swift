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
    
//    func testScale() throws {
//        //let major = try ScaleMode(name: "major", type: .major, intervals: [.maj2nd, .maj2nd, .min2nd, .maj2nd, .maj2nd, .maj2nd, .min2nd])
//        //let minor = try ScaleMode(name: "minor", type: .minor, intervals: [.maj2nd, .min2nd, .maj2nd, .maj2nd, .min2nd, .maj2nd, .maj2nd])
//        let aMinor = Scale(base: .C_, mode: .minor)
//        let cMajor = Scale(base: .C_, mode: .major)
//        let bFlatBlues = Scale(base: .B_Flat, mode: .blues)
//        
//        print (aMinor.tones)
//        print (cMajor.tones)
//        print (bFlatBlues.tones)
//        for i in 0...127 {
//            print (i.tone, terminator: "   ")
//        }
//        print ()
//    }
    
//    func testTrumpet() {
//        var step = 0
//        for i in 35...89 {
//            if let b = i.trumpetButtons(TrumpetMode.bFlat) {
//                if b.step != step {
//                    print()
//                    step = b.step
//                }
//                print("\(b.button1 ? "🔴" : "⭕️")\(b.button2 ? "🔴" : "⭕️")\(b.button3 ? "🔴" : "⭕️") \(b.step) - \(i.tone) ")
//
//
//            } else {
//                print (i, i.tone)
//            }
//        }
//    }
    func testGridLine() {
        for i:UInt8 in (45...68) {
            let (offset, mark) = i.noteGridLine(scaleType: NotesDictionary.majorScale)
            print (i, "OFFSET", offset, mark.sign)
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
