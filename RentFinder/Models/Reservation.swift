import Foundation

struct Reservation: Codable {
    let numberOfPeople: Int
    let startDate: String
    let endDate: String
    let propertyID: Int
    let reservationID: Int
}
