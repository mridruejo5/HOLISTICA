//
//  CourseCell.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 2/11/23.
//

import SwiftUI

struct CourseCellHeader: View {
    let course: Course
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Explore Our \(course.name) Programs")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
    }
}



#Preview {
    CourseCellHeader(course: testCourses.first!)
}
