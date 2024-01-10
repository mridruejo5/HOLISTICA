//
//  EmptyView.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 7/1/24.
//

import SwiftUI
import AVKit

// Custom Video Player
struct CustomVideoPlayer: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
