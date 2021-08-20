//
//  Trumpet.swift
//  MusicScales
//
//  Created by Łukasz Dziedzic on 20/08/2021.
//

import Foundation

struct TrumpetButtons {
    var button1: Bool
    var button2: Bool
    var button3: Bool
    
    var step: Int
}
struct TrumpetButtonsTone {
    var buttons: TrumpetButtons
    var tone: Tone
}

//extension Tone  {
//    var trumpetButtons: TrumpetButtons? {
//        return trumpetButtons[self]
//    }
//}

//var trumpetButtons : [Tone: TrumpetButtons] = [Tone(note: <#T##Note#>, type: <#T##Tones#>):]
