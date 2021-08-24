//
//  Scale.swift
//  MusicScales (iOS)
//
//  Created by Łukasz Dziedzic on 24/08/2021.
//

import Foundation

public struct Scale {
    let base: UInt8
    let mode: Mode
    
    var tones: [Tone] {
       
        var currentTone = Tone(note: base)
        var result = [currentTone]
        for interval in mode.intervals {
            let nextTone = currentTone + interval
            result.append(nextTone)
            currentTone = nextTone
        }
        return result
    }
}


public extension UInt8 {
    static let C_ : UInt8 = 0
    static      let C_Sharp : UInt8 = 1
    static      let D_Flat : UInt8 = 1
    static let D_: UInt8 = 2
    static      let D_Sharp: UInt8 = 3
    static      let E_Flat: UInt8 = 3
    static let E_: UInt8 = 4
    static let F_: UInt8 = 5
    static      let F_Sharp: UInt8 = 6
    static      let G_Flat: UInt8 = 6
    static let G_: UInt8 = 7
    static      let G_Sharp: UInt8 = 8
    static      let A_Flat: UInt8 = 8
    static let A_: UInt8 = 9
    static      let A_Sharp: UInt8 = 10
    static      let B_Flat: UInt8 = 10
    static let B_: UInt8 = 11
}

var ScaleNames: [String] {
    ["C" ,"C♯","D♭","D","D♯","E♭","E", "F","F♯","G♭","G","G♯","A♭","A","A♯","B♭","B"]
}

let noteNames = ["C", "D", "E", "F", "G", "A", "B"]

var ScaleNotes: [String : UInt8] {
    ["C" : .C_,
     "C♯": .C_Sharp,
     "D♭": .D_Flat,
     "D" : .D_,
     "D♯": .D_Sharp,
     "E♭": .E_Flat,
     "E" : .E_,
     "F" : .F_,
     "F♯": .F_Sharp,
     "G♭": .G_Flat,
     "G" : .G_,
     "G♯": .G_Sharp,
     "A♭": .A_Flat,
     "A" : .A_,
     "A♯": .A_Sharp,
     "B♭": .B_Flat,
     "B" : .B_
    ]
}
