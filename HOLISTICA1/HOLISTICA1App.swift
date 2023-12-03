//
//  HOLISTICA1App.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 18/10/23.
//

import SwiftUI

@main
struct HOLISTICA1App: App {
    @AppStorage("email") var email = ""
    @StateObject var loginVM = LoginVM()
    @StateObject var coursesVM = CoursesVM()
    @StateObject var boughtProgramsVM = BoughtProgramsVM(program: .program1)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginVM)
                .environmentObject(coursesVM)
                .environmentObject(boughtProgramsVM)
                .onOpenURL { url in
                    guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                          let queryItems = components.queryItems,
                          let token = queryItems.first(where: { $0.name == "token" }),
                          let value = token.value else {
                        return
                    }
                    let validation = ValidateUser(APIKey: Data(AK).base64EncodedString(), email: email, token: value)
                }
        }
    }
}
