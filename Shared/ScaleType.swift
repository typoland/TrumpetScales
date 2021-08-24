//
//  ScaleType.swift
//  MusicScales (iOS)
//
//  Created by Łukasz Dziedzic on 24/08/2021.
//

import Foundation

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
