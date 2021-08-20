//
//  ContentView.swift
//  Shared
//
//  Created by Łukasz Dziedzic on 20/08/2021.
//

import SwiftUI
import AudioToolbox

struct ContentView: View {
    
    @State var baseNote: UInt8 = .C_
    @State var mode: Mode = .ionian
    @State var scale: Scale = Scale(base: .C_, mode: .ionian)
    @State var volume: Double = 64
    @State var octave: Int = 0
    @State var bFlatTrumpet: Bool = true
    
    var baseNotesMenu: some View {
        MenuButton(
            label: Text("Base \( scale.base.tone.name)"),
            content: {
                ForEach(ScaleNames, id: \.self) {name in
                    Button("\(name)", action: {
                        baseNote = ScaleNotes[name] ?? 0
                        scale = Scale(base: baseNote, mode: mode)
                        
                    })
                }
            }
        )
    }
    
    var ModesMenu: some View {
        MenuButton("\(mode.name)") {
            ForEach(Modes, id:\.name) { mode in
                Button("\(mode.name)", action: {
                    self.mode = mode
                    scale = Scale(base: baseNote, mode: mode)
                })
            }
        }
    }
    func noteNumber(tone: Tone, octave: Int) -> UInt8 {
        if Int(tone.number) > Int(Interval.octave.semitones) * octave {
            return UInt8(Int(tone.number) + Int(Interval.octave.semitones) * octave)
        } else {
            return 0
        }
    }
    var trumpet: some View {
        HStack {
            ForEach(scale.tones, id:\.self) {tone in
                TrumpetView(mode: bFlatTrumpet ? .bFlat : .c,
                            note: noteNumber(tone: tone, octave: octave))
            }
        }
    }
    
    var octaveStepper: some View {
        Stepper("octave \(octave)", value: $octave, in: -1...5)
    }
    
    var bflatChooser: some View {
        Toggle(isOn: $bFlatTrumpet, label: {
            Text("trumpet B♭")
        })
    }
    var body: some View {
        HStack {
            VStack{
                bflatChooser
                octaveStepper
                Slider( value: $volume, in: 0...127)
                //                    .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                //                    .frame(width: 20)
                //                    .offset(y: 100)
            }
            VStack {
                baseNotesMenu
                ModesMenu
                //Text("\(scale.tones.reduce(into: "", {$0 += "\($1.name) "}))")
                trumpet
                Button("play", action: {play()})
                    
                    .padding()
            }
        }
    }
    
    func play() {
        var sequence : MusicSequence? = nil
        NewMusicSequence(&sequence)
        var track : MusicTrack? = nil
        MusicSequenceNewTrack(sequence!, &track)
        var time = MusicTimeStamp(1.0)
        
        
        let notes : [UInt8] = scale.tones.map({noteNumber(tone: $0, octave: octave)})
        
        for note in notes {
            var MIDInote = MIDINoteMessage(channel: 0,
                                           note: note,
                                           velocity: UInt8(volume),
                                           releaseVelocity: 0,
                                           duration: 1)
            guard let track = track else {fatalError("no track")}
            MusicTrackNewMIDINoteEvent(track, time, &MIDInote)
            time += 1
        }
        
        var musicPlayer : MusicPlayer? = nil
        NewMusicPlayer(&musicPlayer)
        MusicPlayerSetSequence(musicPlayer!, sequence)
        MusicPlayerStart(musicPlayer!)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
