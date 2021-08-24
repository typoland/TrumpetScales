//
//  Mode.swift
//  MusicScales (iOS)
//
//  Created by Łukasz Dziedzic on 24/08/2021.
//

import Foundation

public struct Mode {
    let name: String
    let intervals: [Interval]
    
    static let ionian:  Mode = Mode(name: "Ionian (major)",
                                    intervals: [.maj2nd, .maj2nd, .min2nd, .maj2nd, .maj2nd, .maj2nd, .min2nd])
    static let dorian:  Mode = Mode(name: "Dorian",
                                    intervals: [.maj2nd, .min2nd, .maj2nd, .maj2nd, .maj2nd, .min2nd, .maj2nd])
    static let phryg:   Mode = Mode(name: "Phrygian",
                                    intervals: [.min2nd, .maj2nd, .maj2nd, .maj2nd, .min2nd, .maj2nd, .maj2nd])
    static let lydian:  Mode = Mode(name: "Lydian",
                                    intervals: [.maj2nd, .maj2nd, .maj2nd, .min2nd, .maj2nd, .maj2nd, .min2nd])
    static let mixolid: Mode = Mode(name: "Mixolidian",
                                    intervals: [.maj2nd, .maj2nd, .min2nd, .maj2nd, .maj2nd, .min2nd, .maj2nd])
    static let aeolian: Mode = Mode(name: "Aeolian (minor)",
                                    intervals: [.maj2nd, .min2nd, .maj2nd, .maj2nd, .min2nd, .maj2nd, .maj2nd])
    static let locrian: Mode = Mode(name: "Locrian",
                                    intervals: [.min2nd, .maj2nd, .maj2nd, .min2nd, .maj2nd, .maj2nd, .maj2nd])
    static let blues:   Mode = Mode(name: "blues",
                                    intervals: [.maj2nd, .min2nd, .min2nd, .min3rd, .maj2nd, .min3rd]) // MARK: not tested
}

var Modes : [Mode] = [.ionian, .dorian, .phryg, .lydian, .mixolid, .aeolian, .locrian, .blues]
