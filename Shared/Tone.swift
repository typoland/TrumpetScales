//
//  Tone.swift
//  MusicScales (iOS)
//
//  Created by Łukasz Dziedzic on 24/08/2021.
//

import Foundation

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
