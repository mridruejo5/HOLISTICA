//
//  PurchaseView.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 26/11/23.
//

import SwiftUI

struct PurchaseView: View {
    @EnvironmentObject var boughtProgramsVM:BoughtProgramsVM
    
    @Binding var showPurchasedView:Bool
    
    let program:CoursePrograms
    
    @State var successfulPurchase = false
    @State var message = ""
    
    var body: some View {
        VStack {
            NavigationStack {
                Text("Suscribe")
                    .navigationTitle("Complete Suscription")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                showPurchasedView.toggle()
                            } label: {
                                Text("Cancel")
                            }
                        }
                    }
                
                Button {
                    Task {
                        let boughtProgram = try await Network.shared.purchaseProgram(program: program.id)
                        boughtProgramsVM.boughtPrograms.append(boughtProgram)
                        successfulPurchase.toggle()
                    }
                } label: {
                    Text("Complete Suscription")
                }
                .buttonStyle(.bordered)
                .padding()
            }
        }
        .alert("Error from server",
               isPresented: $boughtProgramsVM.showAlert) {
            Button(action: {}, label: { Text("Ok") })
        } message: {
            Text(boughtProgramsVM.message)
        }
        
        .alert("Suscribed to Program", isPresented: $successfulPurchase) {
            Button {
                showPurchasedView.toggle()
            } label: {
                Text("Ok")
            }
        } message: {
            Text(message)
        }
    }
}

#Preview {
    PurchaseView(showPurchasedView: .constant(true), program: .program1)
        .environmentObject(BoughtProgramsVM(program: .program1))
}
