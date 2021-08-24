//
//  Trumpet.swift
//  MusicScales
//
//  Created by Łukasz Dziedzic on 20/08/2021.
//

import Foundation

public struct TrumpetButtons {
    var button1: Bool
    var button2: Bool
    var button3: Bool
    
    var step: Int
}
typealias TP = TrumpetButtons
private var TrumpetButtonsOrder: [TrumpetButtons] = [
    TP(button1: true,  button2: true,  button3: true,  step: 1), //F#
    TP(button1: true,  button2: false, button3: true,  step: 1), //G
    TP(button1: false, button2: true,  button3: true,  step: 1), //G#
    TP(button1: true,  button2: true,  button3: false, step: 1), //A
    TP(button1: true,  button2: false, button3: false, step: 1), //A#
    TP(button1: false, button2: true,  button3: false, step: 1), //B
    TP(button1: false, button2: false, button3: false, step: 1), //C
    
    TP(button1: true,  button2: true,  button3: true,  step: 2), //C#
    TP(button1: true,  button2: false, button3: true,  step: 2), //D
    TP(button1: false, button2: true,  button3: true,  step: 2), //D#
    TP(button1: true,  button2: true,  button3: false, step: 2), //E
    TP(button1: true,  button2: false, button3: false, step: 2), //F
    TP(button1: false, button2: true,  button3: false, step: 2), //F#
    TP(button1: false, button2: false, button3: false, step: 2), //G
    
    TP(button1: false, button2: true,  button3: true,  step: 3), //G#
    TP(button1: true,  button2: true,  button3: false, step: 3), //A
    TP(button1: true,  button2: false, button3: false, step: 3), //A#
    TP(button1: false, button2: true,  button3: false, step: 3), //B
    TP(button1: false, button2: false, button3: false, step: 3), //C
    
    TP(button1: true,  button2: true,  button3: false, step: 4), //C#
    TP(button1: true,  button2: false, button3: false, step: 4), //D
    TP(button1: false, button2: true,  button3: false, step: 4), //D#
    TP(button1: false, button2: false, button3: false, step: 4), //E
    
    TP(button1: true,  button2: false, button3: false, step: 5), //F
    TP(button1: false, button2: true,  button3: false, step: 5), //F#
    TP(button1: false, button2: false, button3: false, step: 5),  //G
    
    TP(button1: true,  button2: false, button3: false, step: 6), //G#
    TP(button1: true,  button2: true,  button3: false, step: 6), //A
    TP(button1: false, button2: false, button3: false, step: 6), //A#
]


public enum TrumpetMode {
    case c
    case bFlat
    var lowestNote: UInt8 {
        switch self {
        case .c: return 42 + 12
        case .bFlat: return 40 + 12
        }
    }
}

extension UInt8 {
    public func trumpetButtons(_ mode: TrumpetMode) -> TrumpetButtons? {
        guard self >= mode.lowestNote else {
            return nil
        }
        guard self < mode.lowestNote + UInt8(TrumpetButtonsOrder.count) else {
            return nil}
        return TrumpetButtonsOrder[Int(self - mode.lowestNote)]
    }
}
