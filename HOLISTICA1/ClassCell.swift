//
//  ClassCell.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 18/11/23.
//

import SwiftUI
import AVKit

struct ClassCell: View {
    let aClass: ProgramClasses
    @State var isPlaying = false
    let video: ClassesVideos
    
    var body: some View {
        VStack(alignment: .center) {
            if let videoURL = URL(string: video.url) {
                let player = AVPlayer(url: videoURL)
                VideoPlayer(player: player)
                    .frame(height: 199)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .onChange(of: isPlaying) { oldValue in
                        if isPlaying {
                            player.play()
                        }
                        else {
                            player.pause()
                        }
                    }
            } else {
                Image(systemName: "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .foregroundStyle(Color.white)
                    .padding()
                    .padding(.leading, 5)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.redwood)
                    }
                    .shadow(radius: 10)
            }
            VStack(alignment: .leading) {
                Text(aClass.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(aClass.class_status.rawValue)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(aClass.description)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 5)
        }
    }
}


#Preview {
    ClassCell(aClass: .class1, video: .video1)
}
