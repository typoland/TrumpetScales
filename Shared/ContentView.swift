//
//  ContentView.swift
//  Shared
//
//  Created by Łukasz Dziedzic on 20/08/2021.
//

import SwiftUI

struct ContentView: View {
    @State var baseNote: Int = .C_
    @State var mode: Mode = .major
    @State var scale: Scale = Scale(base: .C_, mode: .major)
    
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
        VStack {
            baseNotesMenu
            ModesMenu
            Text("\(baseNote.tone.name)")
            Text("\(scale.tones.description)")
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
