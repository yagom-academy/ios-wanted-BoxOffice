import Foundation

enum DecodeError: Error {
    case dateIntervalDecodeFail(from: String)
    case yearWeekTimeDecodeFail(from: String)
    case dateDecodeFail(from: String)
    case httpResponse(URLResponse?)
}
