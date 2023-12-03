//
//  ProgramCellHeader.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 18/11/23.
//

import SwiftUI

struct ProgramCellHeader: View {
    let program: CoursePrograms
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text("\(program.name)")
                .font(.title2)
                .foregroundColor(.primary)
            
            Text(program.description)
                .font(.callout)
                .foregroundColor(.secondary)
        }
        .multilineTextAlignment(.center)
        .clipShape(.rect(cornerRadius: 10))
    }
}


#Preview {
    ProgramCellHeader(program: .program1)
}
