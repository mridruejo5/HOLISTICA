//
//  ClassesView.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 18/11/23.
//

import SwiftUI
import MRNetwork

struct ClassesView: View {
    @ObservedObject var classesVM:ClassesVM
    @EnvironmentObject var boughtProgramsVM:BoughtProgramsVM
    
    @State var successfulPurchase = false
    let program:CoursePrograms
    
    @State var showAlert = false
    @State var message = ""
    
    var body: some View {
        VStack {
            ProgramCellHeader(program: classesVM.program)
                .padding()
            
            if boughtProgramsVM.boughtPrograms.contains(program) {
                Button {
                    Task {
                        await boughtProgramsVM.unsuscribeProgram(program: program)
                    }
                } label: {
                    Text("Unsuscribe From Program")
                        .frame(maxWidth: .infinity)
                        .padding(5)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.blue)
                .padding(.bottom)
                .padding(.horizontal)
                
            } else {
                Button {
                    Task {
                        let boughtProgram = try await Network.shared.purchaseProgram(program: program.id)
                        boughtProgramsVM.boughtPrograms.append(boughtProgram)
                    }
                    successfulPurchase.toggle()
                } label: {
                    Text("Suscribe")
                        .frame(maxWidth: .infinity)
                        .padding(5)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.blue)
                .padding(.bottom)
                .padding(.horizontal)
            }
            
            Divider()
                .foregroundStyle(Color.charcoal)
                .padding(.top)
                .padding(.horizontal)
            
            List(classesVM.classes) { aclass in
                NavigationLink(destination: ContentViewVideo(aClass: aclass)) {
                    ClassCell(aClass: aclass)
                }
            }
            .listStyle(.inset)
        }
        .navigationBarTitleDisplayMode(.inline)
        
        .alert("Error from server",
               isPresented: $classesVM.showAlert) {
            Button(action: {}, label: { Text("OK") })
        } message: {
            Text(classesVM.message)
        }
        .alert("Error from server",
               isPresented: $boughtProgramsVM.showAlert) {
            Button(action: {}, label: { Text("Ok") })
        } message: {
            Text(boughtProgramsVM.message)
        }
        
        .alert("Suscribed to Program", isPresented: $successfulPurchase) {
            Button {
            } label: {
                Text("Ok")
            }
        } message: {
            Text(message)
        }
    }
}


#Preview {
    ClassesView(classesVM: ClassesVM(program: .program1, classes: testClasses), program: .program1)
        .environmentObject(BoughtProgramsVM(program: .program1))
}
