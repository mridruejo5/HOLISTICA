//
//  ProgramVM.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 11/11/23.
//

import SwiftUI
import MRNetwork

final class ProgramsVM: ObservableObject {
    let network = Network.shared
    
    let course:Course
    
    @Published var programs:[CoursePrograms]
    
    @Published var showAlert = false
    @Published var message = ""
    
    init(course:Course, programs:[CoursePrograms] = []) {
        self.course = course
        self.programs = programs
        
        if programs.isEmpty {
            Task {
                await getProgramsByCourse()
            }
        }
    }
    
    @MainActor func getProgramsByCourse() async {
        do {
            programs = try await network.programsByCourse(course: course.id)
        } catch let error as NetworkError {
            message = error.description
            showAlert.toggle()
        } catch {
            message = error.localizedDescription
            showAlert.toggle()
        }
    }
}
