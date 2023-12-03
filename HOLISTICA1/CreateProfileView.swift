//
//  CreateProfileView.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 3/11/23.
//


import SwiftUI
import MRNetwork

struct CreateProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var loginVM:LoginVM
    @EnvironmentObject var userProfileVM:UserProfileVM
    
    @Binding var showCreateProfile:Bool

    var body: some View {
        
        Form {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Profile Information")
                    .font(.title)
                    .bold()
                    .padding(.top)
                    .frame(maxWidth: .infinity)
                
                if let userInfo = loginVM.userInfo {
                    Text("Welcome to Holistica!, \(userInfo.name).")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
                
                Text("Please provide us with some extra information to complete your profile.")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                
                Divider()
                    .background(Color.charcoal)
                
                HStack {
                    Picker("What is your age?", selection: $userProfileVM.age) {
                        ForEach(2..<100, id: \.self) { age in
                            Text("\(age) años")
                                .tag(age)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Divider()
                    .background(Color.charcoal)
                
                HStack {
                    Picker("What is your height?", selection: $userProfileVM.height) {
                        ForEach(100..<250, id: \.self) { height in
                            Text("\(height) cm")
                                .tag(height)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Divider()
                    .background(Color.charcoal)
                
                HStack {
                    Picker("What is your experience?", selection: $userProfileVM.experience) {
                        ForEach(YogaExperience.allCases) { experience in
                            Text(experience.rawValue.capitalized)
                                .tag(experience)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Divider()
                    .background(Color.charcoal)
                
                HStack {
                    Picker("What is your main goal?", selection: $userProfileVM.goal) {
                        ForEach(YogaGoals.allCases) { goal in
                            Text(goal.rawValue.capitalized)
                                .tag(goal)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Divider()
                    .background(Color.charcoal)
                
                Button {
                    Task {
                        await userProfileVM.save()
                        showCreateProfile.toggle()
                    }
                } label: {
                    Text("Save Profile")
                        .frame(maxWidth: .infinity)
                        .padding(5)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.charcoal)
                .padding(.top)
            }
        }
    }
}



#Preview {
    CreateProfileView(showCreateProfile: .constant(true))
        .environmentObject(LoginVM())
        .environmentObject(UserProfileVM())
}
