//
//  Interval.swift
//  MusicScales
//
//  Created by Łukasz Dziedzic on 20/08/2021.
//

import Foundation

public enum Interval {
    case unison
    case minorSecond
    case majorSecond
    case minorThird
    case majorThird
    case perfectFourth
    case augmentedFourth
    case dimishedFifth
    case perfectFifth
    case minorSixth
    case majorSixth
    case minorSeventh
    case majorSeventh
    case perfectOctave
    
    var semitones: Int {
        switch self {
        case .unison: return 0
        case .minorSecond: return 1
        case .majorSecond: return 2
        case .minorThird: return 3
        case .majorThird: return 4
        case .perfectFourth: return 5
        case .augmentedFourth: return 6
        case .dimishedFifth: return 6
        case .perfectFifth: return 7
        case .minorSixth: return 8
        case .majorSixth: return 9
        case .minorSeventh: return 10
        case .majorSeventh: return 11
        case .perfectOctave: return 12
        }
    }
    
    
    
    public static func + (lhs: Interval, rhs: Interval) -> Int {
        lhs.semitones + rhs.semitones
    }
    public static func + (lhs: Int, rhs:Interval) -> Int {
        lhs + rhs.semitones
    }
    
    public static func + (lhs: Tone, rhs: Interval) -> Tone {
        let i = lhs.note.rawValue + rhs
        let note = Note(rawValue: i % Interval.perfectOctave.semitones)!
        let octave = lhs.octave + i / Interval.perfectOctave.semitones
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
            if intervals[index-1] == .minorSecond && intervals[index] == .minorSecond {
                throw Errors.twoSemitonesInRow(tone: index)
            }
            if intervals[index-1] == .minorThird && intervals[index] == .minorThird {
                throw Errors.twoTriHalfsInRow(tone: index)
            }
        }
        guard intervals.reduce(0, +) == Interval.perfectOctave.semitones else {throw Errors.isNotOctave}
            self.intervals = intervals
    }
}

public struct Scale {
    let mode: ScaleMode
    let base: Note
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
    let note: Note
    let type: Tones
    let octave: Int
    
    init (note: Note, type: Tones, octave: Int = 3) {
        self.note = note
        self.type = type
        self.octave = octave
    }
    
    var name: String {
        return note.name(type)
    }
    
    public var number: Int {
        octave * Interval.perfectOctave.semitones + Interval.perfectOctave.semitones * 2
    }
}

extension Tone: CustomStringConvertible {
    public  var description: String {
        type.names[note.rawValue] + "\(octave)"
    }
}

public enum Note: Int {

    case C
    case C_
    case D
    case D_
    case E
    case F
    case F_
    case G
    case G_
    case A
    case A_
    case B
    func name(_ tones:Tones) -> String {
        return tones.names[self.rawValue]
    }
}
extension Int {
    var tone: Tone {
        let base = self
        let r =  base % Interval.perfectOctave.semitones
        let o = r >= 0 ? r : r - Interval.perfectOctave.semitones
        let note = Note(rawValue:o)!
     
        let octave = base / Interval.perfectOctave.semitones
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
