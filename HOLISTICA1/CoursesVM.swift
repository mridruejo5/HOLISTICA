//
//  CoursesVM.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 2/11/23.
//

import SwiftUI
import MRNetwork

final class CoursesVM: ObservableObject {
    let network = Network.shared
    
    @Published var courses:[Course]

    @Published var showLogin = false
    @Published var showAlert = false
    @Published var message = ""
    
    
    init(courses:[Course] = []) {
        self.courses = courses
        
        if courses.isEmpty {
            Task { 
                await getAllCourses()
            }
        }
    }
    
    @MainActor func getAllCourses() async {
        do {
            courses = try await network.allCourses()
        }  catch let error as NetworkError {
            message = error.description
            showAlert.toggle()
        } catch {
            message = error.localizedDescription
            showAlert.toggle()
        }
    }
}

