//
//  ContentView2.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 12/11/23.
//

import SwiftUI

struct ContentView2: View {
    @EnvironmentObject var loginVM:LoginVM
    @ObservedObject var coursesVM = CoursesVM()
    
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
                    .transition(.opacity)
            }
        }
        .animation(.default, value: loginVM.showLogin)
        .animation(.spring().delay(1), value: loginVM.showLogin)
        
        .onAppear {
            loginVM.initLogin()
            //coursesVM.init()
        }
        
        .onChange(of: loginVM.showLogin) { oldValue, newValue in
            if !newValue {
                Task {
                    await loginVM.getUserInfo()
                    await coursesVM.getAllCourses()
                }
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
    ContentView2()
        .environmentObject(LoginVM())
}
