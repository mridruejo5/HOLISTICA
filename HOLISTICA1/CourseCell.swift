//
//  CourseCell2.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 10/11/23.
//

import SwiftUI

struct CourseCell: View {
    let course: Course
    
    var body: some View {
        VStack(spacing: 10) {
            //Image(course.icon)
            UIImage(data: course.icon)
                //.resizable()
                //.scaledToFill()
                .padding()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.redwood, lineWidth: 5)
                }
                .background(Color.almond)
                .cornerRadius(10)
                .shadow(radius: 4)
            
            VStack(alignment: .center, spacing: 4) {
                Text("\(course.name) programs")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.top)
                
                Text(course.catchphrase)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding()
        .background(Color.sand)
        .cornerRadius(10)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.redwood, lineWidth: 10)
        }
        .shadow(radius: 4)
    }
}


#Preview {
    CourseCell(course: testCourses.first!)
}
