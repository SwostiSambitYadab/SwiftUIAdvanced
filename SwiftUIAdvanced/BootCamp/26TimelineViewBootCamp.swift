//
//  TimelineViewBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 24/12/24.
//

import SwiftUI

/**
    - Rapid animation TimelineView updates like every microsecond or something
    - If we have multistep animations instead of multiple @State variables we can use Timeline view as it is rapidly executing with time .
 
 */

struct TimelineViewBootCamp: View {
    
    @State private var startTime: Date = .now
    @State private var pauseAnimation: Bool = false
    
    var body: some View {
        VStack {
            TimelineView(.animation(minimumInterval: 0.1, paused: pauseAnimation)) { context in
                Text("\(context.date)")
                
                Text("\(context.date.timeIntervalSince1970)")
                
                // let seconds = Calendar.current.component(.second, from: context.date)
                
                let seconds = context.date.timeIntervalSince(startTime)
                
                Text("\(seconds)")
                
                
                if context.cadence == .live {
                    Text("Cadence:: Live")
                } else if context.cadence == .minutes {
                    Text("Cadence:: Minutes")
                } else if context.cadence == .seconds {
                    Text("Cadence:: Seconds")
                }
                
                
                Rectangle()
                    .frame(width: seconds * 5,
                           height: 100)
                    .animation(.easeInOut, value: seconds)
            }
            
            Button(pauseAnimation ? "PLAY" : "PAUSE") {
                pauseAnimation.toggle()
            }
        }
    }
}

#Preview {
    TimelineViewBootCamp()
}
