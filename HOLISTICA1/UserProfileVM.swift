//
//  UserProfileVM.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 5/11/23.
//

import SwiftUI
import MRNetwork

final class UserProfileVM:ObservableObject {
    let network = Network.shared
    
    @State var name = ""
    @State var age = 18
    @State var height = 150
    @State var experience: YogaExperience = .beginner
    @State var goal: YogaGoals = .flexibility
    @State var image = ""
    
    @Published var showAlert = false
    @Published var message = ""
    
    @Published var userProfile:UserProfile?
    
    
    @MainActor func save() async {
        do {
            let new = CreateProfile(name: name, age: age, height: height, experience: experience, goal: goal, image: image)
            _ = try await network.createProfile(profile: new)
        } catch let error as NetworkError {
            message = error.description
            showAlert.toggle()
        } catch {
            message = error.localizedDescription
            showAlert.toggle()
        }
    }
}
