//
//  LoginVM.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 29/10/23.
//

import SwiftUI
import MRNetwork
import LocalAuthentication

final class LoginVM:ObservableObject {
    let network = Network.shared
    
    @Published var showAlert = false
    @Published var message = ""
    
    @Published var showLogin = false
    @Published var showBiometry = false
    @Published var userInfo:UserInfo?
    
    @State var name = ""
    @State var age = 18
    @State var height = 150
    @State var experience: YogaExperience = .beginner
    @State var goal: YogaGoals = .flexibility
    @State var image = ""
    
    @AppStorage("BIO") var biometry = false
    
    func getBiometryText() -> String {
        "Activate \(SecManager.shared.biometry == .touchID ? "TouchID" : "FaceID")"
    }
    
    func getBiometryImage() -> String {
        SecManager.shared.biometry == .touchID ? "touchid" : "faceid"
    }
    
    func initLogin() {
        if !SecManager.shared.isUserLogged() {
            showLogin = true
        } else {
            Task {
                await getUserInfo()
            }
            if biometry && !SecManager.shared.isBiometryLogged && SecManager.shared.biometry != .none {
                showBiometry = true
            }
        }
    }
    
    @MainActor func getUserInfo() async {
        do {
            userInfo = try await network.userInfo()
        } catch let error as NetworkError {
            message = error.description
            if case .vapor(_, let status) = error, status == 401 {
                SecManager.shared.logout()
                showLogin = true
            } else {
                showAlert.toggle()
            }
        } catch {
            message = error.localizedDescription
            showAlert.toggle()
        }
    }
    
    @MainActor func checkBiometry() async {
        let context = LAContext()
        do {
            let valid = try await context.evaluatePolicy(.deviceOwnerAuthentication,
                                             localizedReason: "Enter passcode to validate your user")
            if valid {
                SecManager.shared.isBiometryLogged = true
                showBiometry = false
            }
        } catch {
            message = "Authentication Error."
            showAlert.toggle()
        }
    }
    
    func logout() {
        SecManager.shared.logout()
        showLogin = true
    }
}
