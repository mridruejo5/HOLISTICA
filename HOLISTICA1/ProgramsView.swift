//
//  ProgramsView.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 10/11/23.
//

import SwiftUI

struct ProgramsView: View {
    @ObservedObject var programsVM:ProgramsVM
    
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                Section {
                    CourseCellHeader(course: programsVM.course)
                        .listRowSeparator(.hidden)
                }
                Divider()
                    .foregroundStyle(Color.charcoal)
                
                    ForEach(programsVM.programs) { program in
                        ZStack {
                            NavigationLink(destination:
                                            ClassesView(classesVM: ClassesVM(program: program), program: program)) {
                                EmptyView().opacity(0.0)
                                    .padding(.horizontal)
                            }
                            ProgramCell(program: program)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Programs")
                .navigationBarTitleDisplayMode(.inline)
                .alert("Error from server", isPresented: $programsVM.showAlert) {
                    Button(action: {}, label: { Text("Ok") })
                    } message: {
                        Text(programsVM.message)
                    }
                    .padding()
                    .searchable(text: $searchText)
        }
    }
}


#Preview {
    NavigationStack {
        ProgramsView(programsVM: ProgramsVM(course: .course1, programs: testPrograms))
    }
}
