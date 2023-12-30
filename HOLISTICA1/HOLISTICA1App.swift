//
//  HOLISTICA1App.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 18/10/23.
//

import SwiftUI

@main
struct HOLISTICA1App: App {
    @StateObject var loginVM = LoginVM()
    @StateObject var coursesVM = CoursesVM()
    @StateObject var boughtProgramsVM = BoughtProgramsVM(program: .program1)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginVM)
                .environmentObject(coursesVM)
                .environmentObject(boughtProgramsVM)
        }
    }
}
