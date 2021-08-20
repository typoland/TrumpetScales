//
//  Interval.swift
//  MusicScales
//
//  Created by Łukasz Dziedzic on 20/08/2021.
//

import Foundation


public extension Int {
    static var C_ = 0
    static      var C_Sharp = 1
    static      var D_Flat = 1
    static var D_ = 2
    static      var D_Sharp = 3
    static      var E_Flat = 3
    static var E_ = 4
    static var F_ = 5
    static      var F_Sharp = 6
    static      var G_Flat = 6
    static var G_ = 7
    static      var G_Sharp = 8
    static      var A_Flat = 8
    static var A_ = 9
    static      var A_Sharp = 10
    static      var B_Flat = 10
    static var B_ = 11
}

var ScaleNames: [String] {
    ["C" ,"C♯","D♭","D","D♯","E♭","E", "F","F♯","G♭","G","G♯","A♭","A","A♯","B♭","B"]
}

var ScaleNotes: [String: Int] {
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


public enum Interval {
    case unison
    case min2nd
    case maj2nd
    case min3rd
    case maj3rd
    case perf4th
    case aug4th
    case dim5th
    case perf5th
    case min6th
    case maj6th
    case min7th
    case maj7th
    case octave
    
    var semitones: Int {
        switch self {
        case .unison: return 0
        case .min2nd: return 1
        case .maj2nd: return 2
        case .min3rd: return 3
        case .maj3rd: return 4
        case .perf4th: return 5
        case .aug4th: return 6
        case .dim5th: return 6
        case .perf5th: return 7
        case .min6th: return 8
        case .maj6th: return 9
        case .min7th: return 10
        case .maj7th: return 11
        case .octave: return 12
        }
    }
    
    
    
    
    public static func + (lhs: Interval, rhs: Interval) -> Int {
        lhs.semitones + rhs.semitones
    }
    public static func + (lhs: Int, rhs:Interval) -> Int {
        lhs + rhs.semitones
    }
    
    public static func + (lhs: Tone, rhs: Interval) -> Tone {
        let i = lhs.note + rhs
        let note =  i % Interval.octave.semitones
        let octave = lhs.octave + i / Interval.octave.semitones
        return Tone(note: note, octave: octave)
    }
}

public struct Mode {
    let name: String
    let intervals: [Interval]
    
    static var major: Mode = Mode(name: "major", intervals: [.maj2nd, .maj2nd, .min2nd, .maj2nd, .maj2nd, .maj2nd, .min2nd])
    static var minor: Mode = Mode(name: "minor", intervals: [.maj2nd, .min2nd, .maj2nd, .maj2nd, .min2nd, .maj2nd, .maj2nd])
    static var blues: Mode = Mode(name: "blues", intervals: [.maj2nd, .min2nd, .min2nd, .min3rd, .min3rd, .min3rd]) // MARK: not tested
}

var Modes : [Mode] = [.major, .minor, .blues]

public struct Scale {
    let base: Int
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

public struct Tone: Hashable {
    let note: Int
    let octave: Int
    
    init (note: Int, octave: Int = 3) {
        self.note = note
        self.octave = octave
    }
    
    var name: String {
        let a = NotesDictionary.major.names[note]
        let b = NotesDictionary.minor.names[note]
        return a == b ? "\(a)" : "\(a)|\(b)"
    }
    
    public var number: Int {
        (octave + 2) * Interval.octave.semitones
    }
}

extension Tone: CustomStringConvertible {
    public  var description: String {
        name + "\(octave)"
    }
}


extension Int {
    var tone: Tone {
        let base = self
        let r =  base % Interval.octave.semitones
        // MARK: Not working ig octave is negative
        let o = r >= 0 ? r : r - Interval.octave.semitones
        let note = o
     
        let octave = base / Interval.octave.semitones
        return Tone(note: note, octave: octave - 2)
    }
}


public enum NotesDictionary {
    case major
    case minor
    var names: [String] {
        switch self {
        case .major:
            return ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
        case .minor:
            return ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"]
            
        }
    }
}

