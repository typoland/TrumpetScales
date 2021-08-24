//
//  Interval.swift
//  MusicScales
//
//  Created by Łukasz Dziedzic on 20/08/2021.
//

import Foundation




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






