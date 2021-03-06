//
//  TrumpetView.swift
//  MusicScales
//
//  Created by Łukasz Dziedzic on 20/08/2021.
//

import SwiftUI
extension TrumpetButtons {
    var color: Color {
        switch step {
        case 0: return .init(hue: 0.25, saturation: 0.4, brightness: 0.5)
        case 1: return .init(hue: 0.40, saturation: 0.5, brightness: 0.6)
        case 2: return .init(hue: 0.55, saturation: 0.5, brightness: 0.7)
        case 3: return .init(hue: 0.70, saturation: 0.7, brightness: 0.8)
        case 4: return .init(hue: 0.85, saturation: 0.8, brightness: 0.9)
        case 5: return .init(hue: 1, saturation: 0.9, brightness: 1.0)
        case 6: return .init(hue: 0.1, saturation: 0.8, brightness: 1)
        default: return .init(hue: 0.10, saturation: 0.3, brightness: 0.4)
        }
    }
}

struct TrumpetView: View {
    var mode: TrumpetMode
    var note: UInt8
    var scaleType: ScaleType
    var buttonSize: CGFloat = 25
    var buttonGap: CGFloat = 6
    
    func button(_ full: Bool, buttons: TrumpetButtons) -> some View {
        
        ZStack{
            if full {
                Circle().fill(buttons.color)
            }
            Circle().stroke( lineWidth: 2.0)
        }.frame(width: buttonSize, height: buttonSize, alignment: .top)
        
    }
    

    var body: some View {
        VStack {
            Text("\(Tone(note: note, octave: 0).name)").font(.largeTitle)
                .minimumScaleFactor(0.01)
                .frame(width: 35, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            NoteView(number: note,
                     bFlat: mode == .bFlat,
                     scaleType: scaleType)
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center) ){
                if let buttons = note.trumpetButtons(mode) {
                    button(buttons.button3, buttons: buttons).offset(y: -(buttonSize + buttonGap))
                    button(buttons.button2, buttons: buttons).offset(y: 0)
                    button(buttons.button1, buttons: buttons).offset(y: buttonSize + buttonGap)
                } else {
                    Rectangle().fill(Color.clear)
                }
            }.frame(width: buttonSize, height: (buttonSize + buttonGap)*3, alignment: .center)
        }
        
    }
}

struct TrumpetView_Previews: PreviewProvider {
    static var previews: some View {
        TrumpetView(mode: .bFlat, note: 61, scaleType: .minorScale)
    }
}
