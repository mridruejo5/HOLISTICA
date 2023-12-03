//
//  CoursesView.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 12/11/23.
//

import SwiftUI

struct CoursesView: View {
    @EnvironmentObject var coursesVM:CoursesVM
    @EnvironmentObject var loginVM:LoginVM
    @EnvironmentObject var boughtProgramsVM:BoughtProgramsVM
    
    @State var showSettings = false
    
    var body: some View {
        NavigationStack {
            List {
                WelcomeToHolisticaCell(user: loginVM.userInfo)
                    .listRowSeparator(.hidden)
                
                Divider()
                    .foregroundStyle(Color.charcoal)
                
                Section {
                    if boughtProgramsVM.boughtPrograms.isEmpty {
                        MyProgramsEmptyCell()
                    } else {
                        ForEach(coursesVM.courses) { course in
                            let programsForCourse = boughtProgramsVM.boughtProgramsForCourse(course: course)
                            
                                    if !programsForCourse.isEmpty {
                                        Section {
                                            ForEach(boughtProgramsVM.boughtProgramsForCourse(course: course)) { program in
                                                ZStack {
                                                    NavigationLink(destination: ClassesView(classesVM: ClassesVM(program: program), program: program)) {
                                                        EmptyView().opacity(0.0)
                                                            .padding(.horizontal)
                                                    }
                                                    BoughtProgramCell(program: program)
                                                }
                                            }
                                        } header: {
                                            Text(course.name)
                                                .font(.headline)
                                                .foregroundStyle(Color.secondary)
                                                .bold()
                                        }
                                }
                            }
                        }
                    } header: {
                        Text("Your programs")
                            .font(.title3)
                            .foregroundStyle(Color.gunmetal)
                            .bold()
                        }
                    .listRowSeparator(.hidden)
                
                Divider()
                    .foregroundStyle(Color.charcoal)
                
                Section {
                    ForEach(coursesVM.courses) { course in
                        ZStack {
                            NavigationLink(destination: ProgramsView(programsVM: ProgramsVM(course: course))) {
                                EmptyView().opacity(0.0)
                                    .padding(.horizontal)
                            }
                            CourseCell(course: course)
                        }
                        .padding(.bottom, 20)
                    }
                } header: {
                    Text("Courses")
                        .font(.title3)
                        .foregroundStyle(Color.gunmetal)
                        .bold()
                }
                .listRowSeparator(.hidden)
            }
            .navigationTitle("HOME")
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    if let userInfo = loginVM.userInfo {
                        Text(userInfo.name)
                            .font(.headline)
                        Text(userInfo.email)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .refreshable {
                await boughtProgramsVM.getBoughtPrograms()
            }
            .alert("Error from server", isPresented: $coursesVM.showAlert) {
                Button(action: {}, label: { Text("Ok") })
            } message: {
                Text(coursesVM.message)
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
                    .frame(alignment: .top)
            }
            .onChange(of: loginVM.showLogin) { oldValue, newValue in
                if !newValue {
                    Task {
                        await loginVM.getUserInfo()
                        //await boughtProgramsVM.getBoughtPrograms()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CoursesView()
            .environmentObject(LoginVM())
            .environmentObject(CoursesVM())
            .environmentObject(BoughtProgramsVM(program: .program1))
    }

}
