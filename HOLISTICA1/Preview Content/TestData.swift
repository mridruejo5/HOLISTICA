//
//  TestData.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 2/11/23.
//

import SwiftUI

let testCourses:[Course] = [.course1, .course2, .course3]

extension Course {
    static let course1 = Course(id: UUID(), name: "Yoga", description: "Dive into the world of tranquility and self-discovery with our Yoga courses. Explore the art of mindfulness and flexibility, and find your inner balance through a variety of yoga styles and practices.", image: Data(), catchphrase: "Discover harmony of body and mind with our transformative Yoga Programs.", type: .yoga, icon: nil)
    static let course2 = Course(id: UUID(), name: "Strength & Balance", description: "Unleash your strength and discover your body's equilibrium with our specialized Fuerza y Equilibrio courses. Develop muscle power, enhance stability, and achieve a harmonious blend of fitness and wellness.", image: Data(), catchphrase: "Forge strength, find balance – unleash your potential with our specialized Strength & Balance Programs.", type: .fuerzaEquilibrio, icon: nil)
    static let course3 = Course(id: UUID(), name: "Qi Flow", description: "Experience the flow of vital energy with our QiFlow courses. Unlock the secrets of Qi Gong and Tai Chi as you cultivate inner vitality, improve posture, and embark on a journey of holistic health and harmony.", image: Data(), catchphrase: "Embark on a journey of energy and flow with our invigorating Qi Flow Programs.", type: .qiFlow, icon: nil)
}

let testPrograms:[CoursePrograms] = [.program1, .program2, .program3, .program4, .program5]

extension CoursePrograms {
    static let program1 = CoursePrograms(id: UUID(), name: "Foundations Program", description: "Kickstart your yoga journey with the Foundations Program. This beginner-friendly series focuses on fundamental poses, breathing techniques, and mindfulness practices to establish a strong and mindful yoga practice.", difficulty: .beginner, image: Data(), programState: .unwatched, courseID: UUID())
    static let program2 = CoursePrograms(id: UUID(), name: "Intermediate Program", description: "Ready to elevate your practice? The Intermediate Program builds on foundational knowledge, introducing more dynamic flows and challenging poses. Dive deeper into breath-to-movement sequences and refine your alignment for a more fluid practice.", difficulty: .intermediate, image: Data(), programState: .unwatched, courseID: UUID())
    static let program3 = CoursePrograms(id: UUID(), name: "Advanced Program", description: "Strengthen and stabilize your body and mind with our Advanced Program. This program incorporates powerful poses and mindful transitions, helping you develop core strength, balance, and mental focus. Ideal for those seeking a more challenging yoga experience.", difficulty: .advanced, image: Data(), programState: .unwatched, courseID: UUID())
    static let program4 = CoursePrograms(id: UUID(), name: "Expert Program", description: "Elevate your practice to new heights with the Expert Program. This series delves into advanced inversions like headstands, handstands, and forearm stands. Cultivate strength, balance, and courage as you explore the upside-down world of yoga.", difficulty: .expert, image: Data(), programState: .unwatched, courseID: UUID())
    static let program5 = CoursePrograms(id: UUID(), name: "Superior Program", description: "Unleash your full potential with the Superior Program. Tailored for experienced practitioners, this program integrates advanced poses, intricate sequences, and profound spiritual teachings. Elevate your yoga journey and deepen your connection with self through this transformative series.", difficulty: .elite, image: Data(), programState: .unwatched, courseID: UUID())
}

let testClasses:[ProgramClasses] = [.class1, .class2, .class3, .class4, .class5]

extension ProgramClasses {
    static let class1 = ProgramClasses(id: UUID(), name: "Breath Mastery Basics", description: "Explore foundational breath control techniques to enhance mindfulness and relaxation.", class_status: .unwatched, video: ClassesVideos(id: UUID(), title: "Strength & Resistence exercises for every day", url: "https://player.vimeo.com/external/887022884.m3u8?s=7f75f6a860ca271ef3753d9dab6324aa590bccd2&logging=false", upload_date: Date(), status: .unwatched))
    static let class2 = ProgramClasses(id: UUID(), name: "Align & Posture Workshop", description: "Learn proper body alignment and posture fundamentals for a strong yoga foundation.", class_status: .unwatched, video: ClassesVideos(id: UUID(), title: "Strength & Resistence exercises for every day", url: "https://player.vimeo.com/external/887022884.m3u8?s=7f75f6a860ca271ef3753d9dab6324aa590bccd2&logging=false", upload_date: Date(), status: .unwatched))
    static let class3 = ProgramClasses(id: UUID(), name: "Mindful Meditation Intro", description: "Discover mindfulness through simple meditation techniques for inner calmness.", class_status: .unwatched, video: ClassesVideos(id: UUID(), title: "Strength & Resistence exercises for every day", url: "https://player.vimeo.com/external/887022884.m3u8?s=7f75f6a860ca271ef3753d9dab6324aa590bccd2&logging=false", upload_date: Date(), status: .unwatched))
    static let class4 = ProgramClasses(id: UUID(), name: "Flex & Flow Stretch", description: "Improve flexibility and mobility with gentle stretches and poses.", class_status: .unwatched, video: ClassesVideos(id: UUID(), title: "Strength & Resistence exercises for every day", url: "https://player.vimeo.com/external/887022884.m3u8?s=7f75f6a860ca271ef3753d9dab6324aa590bccd2&logging=false", upload_date: Date(), status: .unwatched))
    static let class5 = ProgramClasses(id: UUID(), name: "Grounding Hatha Practice", description: "Experience a balanced Hatha yoga flow for stability and calmness.", class_status: .unwatched, video: ClassesVideos(id: UUID(), title: "Strength & Resistence exercises for every day", url: "https://player.vimeo.com/external/887022884.m3u8?s=7f75f6a860ca271ef3753d9dab6324aa590bccd2&logging=false", upload_date: Date(), status: .unwatched))
}

extension UserInfo {
    static let user1 = UserInfo(name: "Miguel Ridruejo", email: "ridruejomiguel@gmail.com", profileCreated: false)
}

extension ClassesVideos {
    static let video1 = ClassesVideos(id: UUID(), title: "Relax & Restore", url: "https://player.vimeo.com/external/868306768.m3u8?s=611460d9c19eb8106950c0a9e613c344e2e42a50&logging=false", upload_date: .now, status: .unwatched)
}

extension UserProfileVM {
    static let userProfileVMTest = UserProfileVM()
}

extension CoursesVM {
    static let coursesVMTest = CoursesVM(courses: testCourses)
}

extension ProgramsVM {
    static let programVMTest = ProgramsVM(course: .course1, programs: testPrograms)
}
