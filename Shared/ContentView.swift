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
    @State var mode: Mode = .major
    @State var scale: Scale = Scale(base: .C_, mode: .major)
    @State var volume: Double = 64
    
    var baseNotesMenu: some View {
        MenuButton(
            label: Text("Base"),
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
        MenuButton("mode: \(mode.name)") {
            ForEach(Modes, id:\.name) { mode in
                Button("\(mode.name)", action: {
                        self.mode = mode
                    scale = Scale(base: baseNote, mode: mode)
                })
            }
        }
    }
    
    var body: some View {
        HStack {
            VStack{
               
                Slider( value: $volume, in: 0...127)
//                    .rotationEffect(.degrees(-90.0), anchor: .topLeading)
//                    .frame(width: 20)
//                    .offset(y: 100)
            }
        VStack {
            baseNotesMenu
            ModesMenu
            Text("\(baseNote.tone.name)")
            Text("\(scale.tones.description)")
            Button("play", action: {play()})
                    
            .padding()
        }
        }
    }
    
    func play() {
        var sequence : MusicSequence? = nil
        var musicSequenceStatus: OSStatus = NewMusicSequence(&sequence)
        var track : MusicTrack? = nil
        var musicTrack = MusicSequenceNewTrack(sequence!, &track)
        var time = MusicTimeStamp(1.0)
        
        
        let notes : [UInt8] = scale.tones.map({$0.number})
        
        for note in notes {
            var MIDInote = MIDINoteMessage(channel: 0,
                                           note: note,
                                           velocity: UInt8(volume),
                                           releaseVelocity: 0,
                                           duration: 1)
            guard let track = track else {fatalError("no track")}
            musicTrack = MusicTrackNewMIDINoteEvent(track, time, &MIDInote)
            time += 1
        }
        
        var musicPlayer : MusicPlayer? = nil
        var player = NewMusicPlayer(&musicPlayer)
        player = MusicPlayerSetSequence(musicPlayer!, sequence)
        player = MusicPlayerStart(musicPlayer!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
