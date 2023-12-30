//
//  CoursesView2.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 17/12/23.
//

import SwiftUI

struct CoursesView: View {
    @EnvironmentObject var coursesVM:CoursesVM
    @EnvironmentObject var loginVM:LoginVM
    @EnvironmentObject var boughtProgramsVM:BoughtProgramsVM
    
    @State var showSettings = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Divider()
                
                WelcomeToHolisticaCell(user: loginVM.userInfo)
                
                Divider()
                
                Text("Your programs")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                
                if boughtProgramsVM.boughtPrograms.isEmpty {
                    MyProgramsEmptyCell()
                } else {
                    ForEach(coursesVM.courses) { course in
                        let programsForCourse = boughtProgramsVM.boughtProgramsForCourse(course: course)
                        
                        if !programsForCourse.isEmpty {
                            Text(course.name)
                                .font(.headline)
                                .foregroundStyle(Color.secondary)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            ForEach(boughtProgramsVM.boughtProgramsForCourse(course: course)) { program in
                                ZStack {
                                    NavigationLink(destination: ClassesView(classesVM: ClassesVM(program: program), program: program)) {
                                        BoughtProgramCell(program: program)
                                            .foregroundStyle(Color.primary)
                                            .padding()
                                    }
                                }
                            }
                        }
                    }
                }
                
                Divider()
                    .padding(.top)
                
                VStack {
                    Text("Courses")
                        .font(.title2)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)

                    ForEach(coursesVM.courses) { course in
                        ZStack {
                            NavigationLink(destination: ProgramsView(programsVM: ProgramsVM(course: course))) {
                                CourseCell(course: course)
                                    .foregroundStyle(Color.primary)
                                    .padding(.vertical)
                            }
                        }
                    }
                }
            }
            .background(Color.white)
            .navigationTitle("HOME")
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
