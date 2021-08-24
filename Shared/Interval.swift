//
//  Interval.swift
//  MusicScales
//
//  Created by Łukasz Dziedzic on 20/08/2021.
//

import Foundation


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
    
    var semitones: UInt8 {
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
    
    public static func + (lhs: Interval, rhs: Interval) -> UInt8 {
        lhs.semitones + rhs.semitones
    }
    public static func + (lhs: UInt8, rhs:Interval) -> UInt8 {
        lhs + rhs.semitones
    }
    
    
}

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

public struct Tone: Hashable {
    let note: UInt8
    let octave: Int8
    
    init (note: UInt8, octave: Int8 = 3) {
        self.note = note % Interval.octave.semitones
        self.octave = octave + Int8(note / Interval.octave.semitones)
    }
    
    var name: String {
        let a = ScaleType.majorScale.names[Int(note)]
        let b = ScaleType.minorScale.names[Int(note)]
        return a == b ? "\(a)" : "\(a) \(b)"
    }
    
    public var midiNoteNumber: UInt8 {
        UInt8(UInt8(octave + 2) * Interval.octave.semitones) + note
    }
    
    public static func + (lhs: Tone, rhs: Interval) -> Tone {
        let i = lhs.note + rhs
        let note =  i % Interval.octave.semitones
        let octave = lhs.octave +  Int8 (i / Interval.octave.semitones)
        return Tone(note: note, octave: octave)
    }
    
    public static func + (lhs: Tone, rhs: Int8) -> Tone {
        let semitones = Int8(Interval.octave.semitones)
        let i = Int8(lhs.note) + rhs
        let note =  i % semitones
        let octave = lhs.octave +  Int8 (i / semitones)
        return Tone(note: note < 0 ? UInt8(note + semitones) : UInt8(note), octave: note < 0 ? octave-1 : octave)
    }
    
    public static func - (lhs: Tone, rhs: Int8) -> Tone {
        return lhs + -rhs
    }
}

extension Tone: CustomStringConvertible {
    public  var description: String {
        name + "\(octave)"
    }
}

extension UInt8 {
    var tone: Tone {
        let base = self
        let note =  base % Interval.octave.semitones
        // MARK: Not working if octave is negative
        //let o = r >= 0 ? r : r - Interval.octave.semitones
        //let note = o
     
        let octave =  Int8 (base / Interval.octave.semitones)
        return Tone(note: note, octave: octave - 2)
    }
}
enum HalfTone {
    case sharp
    case flat
    case none
    var text: String {
        switch self {
        case .sharp:
            return "♯"
        case .flat:
            return "♭"
        default:
            return ""
        }
    }
    var sign: Character? {
        switch self {
        case .sharp:
            return "\u{E10E}"
        case .flat:
            return "\u{E11A}"
        case .none:
            return nil
        }
    }
}
struct LineOffset {
    
    var step: Int8
    var mark: HalfTone
}

let noteNames = ["C", "D", "E", "F", "G", "A", "B"]

public enum ScaleType {
    typealias LO = LineOffset
    case majorScale
    case minorScale
    
    init (name: String) {
        self = name.contains(HalfTone.flat.text) ?
            .minorScale : .majorScale
    }
    
    var names: [String] {
        LineSteps.map {noteNames[Int($0.step)] + "\($0.mark.text)" }
    }
    
    var LineSteps: [LineOffset] {
        switch  self {
        case .majorScale:
            return [LO(step: 0, mark: .none),
                    LO(step: 0, mark: .sharp),
                    LO(step: 1, mark: .none),
                    LO(step: 1, mark: .sharp),
                    LO(step: 2, mark: .none),
                    LO(step: 3, mark: .none),
                    LO(step: 3, mark: .sharp),
                    LO(step: 4, mark: .none),
                    LO(step: 4, mark: .sharp),
                    LO(step: 5, mark: .none),
                    LO(step: 5, mark: .sharp),
                    LO(step: 6, mark: .none)]
        case .minorScale:
            return [LO(step: 0, mark: .none),
                    LO(step: 1, mark: .flat),
                    LO(step: 1, mark: .none),
                    LO(step: 2, mark: .flat),
                    LO(step: 2, mark: .none),
                    LO(step: 3, mark: .none),
                    LO(step: 4, mark: .flat),
                    LO(step: 4, mark: .none),
                    LO(step: 5, mark: .flat),
                    LO(step: 5, mark: .none),
                    LO(step: 6, mark: .flat),
                    LO(step: 6, mark: .none)]
        }
    }
}

