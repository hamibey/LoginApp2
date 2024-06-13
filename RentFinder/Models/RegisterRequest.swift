import Foundation

struct RegisterRequest: Codable {
    let name: String
    let surname: String
    let email: String
    let password: String
    let phoneNumber: String
    let dateOfBirth: String
}
