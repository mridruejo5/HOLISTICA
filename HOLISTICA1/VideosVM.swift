//
//  VideosVM.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 30/12/23.
//

import SwiftUI
import MRNetwork

final class VideosVM: ObservableObject {
    let network = Network.shared
    
    let aClass:ProgramClasses
    
    @Published var video:ClassesVideos
    
    @Published var showAlert = false
    @Published var message = ""
    
    init(aClass:ProgramClasses, video:ClassesVideos) {
        self.aClass = aClass
        self.video = video
        
        Task {
            await getVideoByClass()
        }
    }
    
    @MainActor func getVideoByClass() async {
        do {
            video = try await network.videoByClass(aClass: aClass.id)
        } catch let error as NetworkError {
            message = error.description
            showAlert.toggle()
        } catch {
            message = error.localizedDescription
            showAlert.toggle()
        }
    }
}
