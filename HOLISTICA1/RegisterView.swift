//
//  RegisterView.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 21/10/23.
//

import SwiftUI
import MRNetwork

struct RegisterView: View {

    @Binding var showRegister:Bool
    @Binding var showLogin:Bool
    
    @State var name = ""
    @State var user = ""
    @State var pass = ""
    @State var newpass = ""
    @State var profileCreated = false
    
    @State var showAlert = false
    @State var successRegistrationAlert = false
    @State var message = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Register")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .padding(.top, 75)
            
            Divider()
                .background(Color.charcoal)
                .padding(.bottom)
            
            Text("Name")
            TextField("Enter your name", text: $name)
                .textContentType(.name)
                .textInputAutocapitalization(.words)
            Text("Username (email)")
                .padding(.top)
            TextField("Enter your username", text: $user)
                .textContentType(.username)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            Text("Password")
                .padding(.top)
            TextField("Enter your password", text: $pass)
                .textContentType(.newPassword)
            Text("Repeat password")
                .padding(.top)
            TextField("Confirm the password", text: $newpass)
                .textContentType(.newPassword)
            
            Button {
                let new = CreateUser(name: name, email: user, password: pass, newPassword: newpass, APIKey: Data(AK).base64EncodedString(), dateCreated: Date.now.ISO8601Format())
                Task {
                    do {
                        try await Network.shared.createUser(user: new)
                        showLogin = !SecManager.shared.isUserLogged()
                        successRegistrationAlert.toggle()
                    } catch let error as NetworkError {
                        message = error.description
                        showAlert.toggle()
                    } catch {
                        message = error.localizedDescription
                        showAlert.toggle()
                    }
                }
            } label: {
                Text("Register")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.charcoal)
            .padding(.top)
            
            Button {
                showRegister.toggle()
            } label: {
                Text("I already have an account")
                    .font(.callout)
                    .frame(alignment: .trailing)
                    .padding(.top)
            }
            
            Spacer()
            
            Text("Copyright 2023 – holistica.es")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, maxHeight: 700, alignment: .bottom)
                    .padding(.bottom)
        }
        .padding(.horizontal, 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background {
            Color.sand
                .opacity(0.7)
        }
        .cornerRadius(10)
        .ignoresSafeArea()
        .textFieldStyle(.roundedBorder)

        .alert("User creation error", isPresented: $showAlert) {
            Button(action: {}, label: { Text("Ok") })
        } message: {
            Text(message)
        }
        .alert("User Created", isPresented: $successRegistrationAlert) {
            Button {
                showRegister.toggle()
            } label: {
                Text("Go to login")
            }
        } message: {
            Text(message)
        }
    }
}

#Preview {
    RegisterView(showRegister: .constant(true), showLogin: .constant(false))
}
