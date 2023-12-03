//
//  CourseCell.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 2/11/23.
//

import SwiftUI

struct CourseCell: View {
    let course: Course
    
    var body: some View {
        HStack(spacing: 10) {
            Image(course.image)
                .resizable()
                .scaledToFill()
                .padding()
                .frame(width: 80, height: 80)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gunmetal, lineWidth: 5)
                }
                .background(Color.charcoal)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(course.name) Programs")
                    .font(.title)
                    .foregroundColor(.primary)
                
                Text(course.catchphrase)
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: 125, alignment: .top)
        .padding(20)
        .background {
            Rectangle()
                .foregroundStyle(Color.cadetGray)
                .ignoresSafeArea()
                .shadow(radius: 4)
        }
        
    }
}



#Preview {
    CourseCell(course: testCourses.first!)
}
