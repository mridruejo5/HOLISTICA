//
//  ContentViewVideo.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 7/1/24.
//

import SwiftUI

struct ContentViewVideo: View {
    var aClass: ProgramClasses
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            if let video = aClass.video {
                HomeVideo(video: video.url, aClass: aClass, size: size, safeArea: safeArea)
            }
        }
    }
}
#Preview {
    ContentViewVideo(aClass: .class2)
}
