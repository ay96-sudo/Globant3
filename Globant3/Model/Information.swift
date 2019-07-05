import Foundation

// MARK: - Information
struct Information: Codable {
    let firstName: String
    let lastName: String
    let age: String
    let city: String
    let photo: String?
    let skills: [String]
    let contactInfo: ContactInfo
    let programming: [Programming]?
    let schoolSummary: SchoolSummary
    let workExperience: [WorkExperience]?

}

// MARK: - Programming
struct Programming: Codable {
    let language: String
    let time: String
}

// MARK: - WorkExperience
struct WorkExperience: Codable {
    let company: String
    let start: String
    let description: String
}

// MARK: - ContactInfo
struct ContactInfo: Codable {
    let email: String
    let cellphone: String
    let linkedIn: String
}

// MARK: - SchoolSummary
struct SchoolSummary: Codable {
    let university: String
    let career: String
    let generation: String
}
