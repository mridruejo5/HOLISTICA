//
//  BoughtProgramsVM.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 25/11/23.
//

import SwiftUI
import MRNetwork

final class BoughtProgramsVM: ObservableObject {
    let network = Network.shared
    
    @Published var showAlert = false
    @Published var message = ""
    
    let program:CoursePrograms
    
    @Published var boughtPrograms:[CoursePrograms]
    
    init(program:CoursePrograms, boughtPrograms:[CoursePrograms] = []) {
        self.program = program
        self.boughtPrograms = boughtPrograms
        
        Task {
            await getBoughtPrograms()
        }
    }
    
    @MainActor func getBoughtPrograms() async {
        do {
            boughtPrograms = try await network.boughtPrograms()
        } catch let error as NetworkError {
            message = error.description
            showAlert.toggle()
        } catch {
            message = error.localizedDescription
            showAlert.toggle()
        }
    }
    
    @MainActor func unsuscribeProgram(program: CoursePrograms) async {
        do {
            let unsuscribeProgram = try await network.unsuscribe(program: program.id)
            boughtPrograms.removeAll { program in
                program.id == unsuscribeProgram.id
            }
            /*
            boughtPrograms.forEach { aProgram in
                if aProgram.id == unsuscribeProgram.id {
                    if let indexToRemove = boughtPrograms.firstIndex(where: { $0.id == unsuscribeProgram.id }) {
                        boughtPrograms.remove(at: indexToRemove)
                    }
                }
            }
            */
        } catch let error as NetworkError {
            message = error.description
            showAlert.toggle()
        } catch {
            message = error.localizedDescription
            showAlert.toggle()
        }
    }
    
    
    func boughtProgramsForCourse(course: Course) -> [CoursePrograms] {
        boughtPrograms.filter { program in
            program.courseID == course.id
        }
    }
}
