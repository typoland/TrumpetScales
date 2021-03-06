//
//  NoteView.swift
//  MusicScales
//
//  Created by Łukasz Dziedzic on 21/08/2021.
//

import SwiftUI
extension String {
    static let keyC = "\u{E1A5}"
    static let keyG = "\u{E1AA}"
    static let note = "\u{E134}"
}


extension UInt8 {
    func noteGridLine(scaleType: ScaleType) -> (Int8, HalfTone) {
        let firstLineTone = Tone(note: .C_, octave: 4)
        let thisTone = Tone(note: self, octave: -2)
        let octaveInterval =  thisTone.octave - firstLineTone.octave
//        print ("\t",firstLineTone.name, thisTone.name, octaveInterval)
//        let gridTone = firstLineNote + interval
//        let octaveInterval = gridTone.octave - firstLineNote.octave
        let baseOffset = scaleType.LineSteps[Int(firstLineTone.note)]
        let lineOffset = scaleType.LineSteps[Int(thisTone.note)]
//        print ("\t",baseOffset.step, lineOffset.step)
        let gridLines = octaveInterval * 7  + baseOffset.step + lineOffset.step
        //print (lineOffset.step, gridLines, lineOffset.mark.sign)
//        return (0, .none)
        return (gridLines, lineOffset.mark)
    }
}

struct NoteView: View {
    var number: UInt8
    var bFlat: Bool
    var scaleType: ScaleType
    let lineGap: CGFloat = 5
    
    func realOffset(from: Int8) -> CGFloat {
        return  -4*lineGap + CGFloat(from) * lineGap
    }
    var bFlatOffset: UInt8 {
        return bFlat ? 2 : 0
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center))
       {
            ForEach((0...4), id:\.self) { idx in
                Rectangle().frame(width: 70, height: 1, alignment: .center)
                    .offset(y: CGFloat(idx)*lineGap*2)
                    .foregroundColor(.primary)
                    
            }

            let (offset, sign) = (number + bFlatOffset).noteGridLine(scaleType: scaleType)
           // Text("\(offset)")//.border(Color.blue)
            if offset < -6 {
                ForEach(((offset+1)/2 ... -3), id:\.self) { idx in
                    Rectangle().frame(width: 17, height: 1, alignment: .center)
                        .offset(y: -CGFloat(idx)*lineGap*2+lineGap*4)
                        .foregroundColor(.primary)
                }
            }
            if offset > 4 {
                ForEach((2 ... (offset-1)/2), id:\.self) { idx in
                    Rectangle().frame(width: 17, height: 1, alignment: .center)
                        .offset(y: -CGFloat(idx)*lineGap*2+lineGap*2)
                        .foregroundColor(.primary)
                }
            }
            Text("\(sign.sign?.description ?? "")\(.note)")
                .font(Font.custom("emmentaler", size: lineGap*6)) // 8 for MacOS and simulators
                .offset(y: -realOffset(from: offset))
        }
        .frame(width:30)
        .offset(y: -25)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(number: Tone(note: .C_, octave: 3).midiNoteNumber,
                 bFlat: true,
                 scaleType: .majorScale)
    }
}
