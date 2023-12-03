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
    
    @State var showPurchasedView = false
    
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
                    showPurchasedView.toggle()
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
                ClassCell(aClass: aclass)
            }
            .listStyle(.plain)
        }
        .navigationBarTitleDisplayMode(.inline)
        
        .alert("Error from server",
               isPresented: $classesVM.showAlert) {
            Button(action: {}, label: { Text("OK") })
        } message: {
            Text(classesVM.message)
        }
        
        .fullScreenCover(isPresented: $showPurchasedView) {
            PurchaseView(showPurchasedView: $showPurchasedView, program: program)
                .frame(alignment: .top)
        }
    }
    /*
    var header: some View {
        HStack {
            Text("Classes")
                .font(.title)
        }
        .padding(.horizontal)
    }
     */
}


#Preview {
    ClassesView(classesVM: ClassesVM(program: .program1, classes: testClasses), program: .program1)
        .environmentObject(BoughtProgramsVM(program: .program1))
}
