//
//  ClassesVM.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 18/11/23.
//

import SwiftUI
import MRNetwork

final class ClassesVM: ObservableObject {
    let network = Network.shared
    
    let program:CoursePrograms
    
    @Published var classes:[ProgramClasses]
    
    @Published var showAlert = false
    @Published var message = ""
    
    init(program:CoursePrograms, classes:[ProgramClasses] = []) {
        self.program = program
        self.classes = classes
        
        if classes.isEmpty {
            Task {
                await getClassesByProgram()
            }
        }
    }
    
    @MainActor func getClassesByProgram() async {
        do {
            classes = try await network.classesByProgram(program: program.id)
        } catch let error as NetworkError {
            message = error.description
            showAlert.toggle()
        } catch {
            message = error.localizedDescription
            showAlert.toggle()
        }
    }
}
