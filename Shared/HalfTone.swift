//
//  HalfTone.swift
//  MusicScales (iOS)
//
//  Created by Łukasz Dziedzic on 24/08/2021.
//

import Foundation
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
