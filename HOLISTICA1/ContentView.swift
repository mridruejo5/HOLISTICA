//
//  ContentView2.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 12/11/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginVM:LoginVM
    @EnvironmentObject var coursesVM:CoursesVM
    @EnvironmentObject var boughtProgramsVM:BoughtProgramsVM
    
    @State var showCreateProfile = false
    
    var body: some View {
        Group {
            if loginVM.showLogin {
                LoginRegisterView(showLogin: $loginVM.showLogin)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            } else if loginVM.showBiometry {
                BiometryLogin()
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            } else {
                CoursesView()
            }
        }
        .animation(.default, value: loginVM.showLogin)
        .animation(.spring().delay(1), value: loginVM.showLogin)
        .onChange(of: loginVM.showLogin) {newValue in
            if !newValue {
                Task {
                    await loginVM.getUserInfo()
                    await boughtProgramsVM.getBoughtPrograms()
                    await coursesVM.getAllCourses()
                }
            }
        }
        .onAppear {
            loginVM.initLogin()
            Task {
                await boughtProgramsVM.getBoughtPrograms()
            }
        }
        
        .alert("User log in error",
               isPresented: $loginVM.showAlert) {
            Button(action: {}, label: { Text("OK") })
        } message: {
            Text(loginVM.message)
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(LoginVM())
        .environmentObject(CoursesVM())
        .environmentObject(BoughtProgramsVM(program: .program1))
}
