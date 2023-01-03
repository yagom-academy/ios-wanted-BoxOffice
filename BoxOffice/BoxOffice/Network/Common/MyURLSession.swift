//
//  MyURLSession.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

import Foundation

struct MyURLSession: APIService {

    // MARK: Properties

    private let session: URLSession

    // MARK: - Initializers

    init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - Methods

    func execute<T: APIRequest>(
        _ request: T,
        completion: @escaping (Result<T.APIResponse, APIError>) -> Void
    ) {
        guard let request = request.urlRequest else {
            completion(.failure(.invalidRequest))

            return
        }

        callHandler(completion, from: request)
    }

    private func callHandler<T: Decodable>(
        _ completion: @escaping (Result<T, APIError>) -> Void,
        from request: URLRequest
    ) {
        session.dataTask(with: request) { data, response, error in
            if let apiError = checkAPIErrorFrom(response, error) {
                completion(.failure(apiError))
            }

            completion(checkIntegrity(of: data))
        }.resume()
    }

    private func checkAPIErrorFrom(
        _ response: URLResponse?,
        _ error: Error?
    ) -> APIError? {
        if let error = error {
            return .unknownError(error)
        }

        guard let response = response as? HTTPURLResponse else {
            return .invalidResponse
        }

        guard (200..<300).contains(response.statusCode) else {
            return .abnormalStatusCode(response.statusCode)
        }

        return nil
    }

    private func checkIntegrity<T: Decodable>(
        of data: Data?
    ) -> Result<T, APIError> {
        guard let verifiedData = data else {
            return .failure(.emptyData)
        }
        
        if let parsedData: T = parse(verifiedData) {
            return .success(parsedData)
        } else if let parsedPNGData = parse(verifiedData) as? T {
            return .success(parsedPNGData)
        } else {
            return .failure(.failedToParse)
        }
    }
}
