//
//  Interval.swift
//  MusicScales
//
//  Created by Łukasz Dziedzic on 20/08/2021.
//

import Foundation


extension Int {
    static var C_ = 0
    static      var C_Sharp = 1
    static      var D_Flat = 1
    static var D_ = 2
    static      var D_Sharp = 3
    static      var E_Down = 3
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
        return Tone(note: note, type: lhs.type, octave: octave)
    }
}


public struct ScaleMode {
    enum Errors: Error {
        case twoSemitonesInRow(tone: Int)
        case twoTriHalfsInRow(tone: Int)
        case isNotOctave
    }
    
    let name: String
    let intervals: [Interval]
    let type: Tones
    
    public init(name: String, type: Tones, intervals: [Interval]) throws {
        self.name = name
        self.type = type
        for index in 1..<intervals.count {
            if intervals[index-1] == .min2nd && intervals[index] == .min2nd {
                throw Errors.twoSemitonesInRow(tone: index)
            }
            if intervals[index-1] == .min3rd && intervals[index] == .min3rd {
                throw Errors.twoTriHalfsInRow(tone: index)
            }
        }
        guard intervals.reduce(0, +) == Interval.octave.semitones else {throw Errors.isNotOctave}
            self.intervals = intervals
    }
}

public struct Scale {
    let mode: ScaleMode
    let base: Int
    var tones: [Tone] {
       
        var currentTone = Tone(note: base, type: mode.type)
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
    let type: Tones
    let octave: Int
    
    init (note: Int, type: Tones, octave: Int = 3) {
        self.note = note
        self.type = type
        self.octave = octave
    }
    
    var name: String {
        return type.names[note]
    }
    
    public var number: Int {
        octave * Interval.octave.semitones + Interval.octave.semitones * 2
    }
}

extension Tone: CustomStringConvertible {
    public  var description: String {
        type.names[note] + "\(octave)"
    }
}

//public enum Note: Int {
//
//    case C
//    case C_
//    case D
//    case D_
//    case E
//    case F
//    case F_
//    case G
//    case G_
//    case A
//    case A_
//    case B
//    func name(_ tones:Tones) -> String {
//        return tones.names[self.rawValue]
//    }
//}


extension Int {
    var tone: Tone {
        let base = self
        let r =  base % Interval.octave.semitones
        // MARK: Not working ig octave is negative
        let o = r >= 0 ? r : r - Interval.octave.semitones
        let note = o
     
        let octave = base / Interval.octave.semitones
        return Tone(note: note, type: .minor, octave: octave - 2)
    }
}


public enum Tones {
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

