//
//  NetworkService.swift
//  BoxOffice
//
//  Created by brad on 2023/01/04.
//

import SwiftUI
import Combine


enum NetworkMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}

struct RequestBuilder {
    let url: URL?
    let method: NetworkMethod = .get
    let body: Data?
    let headers: [String: String]?

    func create() -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        if let body = body {
            request.httpBody = body
        }
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        return request
    }
}

final class NetworkService {

    enum NetworkError: Error {
        case invalidRequest
        case unknownError(message: String)
    }

    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func request(request: URLRequest) -> AnyPublisher<Data, NetworkError> {
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidRequest
                }
                return data
            }
            .mapError { error -> NetworkError in
                .unknownError(message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }

    deinit {
        session.invalidateAndCancel()
    }
}

class URLImageLoader: ObservableObject {
    @Published var image = UIImage(systemName: "photo.artframe")

    private let network = NetworkService(session: URLSession.shared)
    private var cancellables = Set<AnyCancellable>()

    func fetch(urlString: String?) {
        guard let urlString = urlString else { return }
        let url = URL(string: urlString)
        let urlRequest = RequestBuilder(url: url,
                                        body: nil,
                                        headers: nil).create()

        guard let request = urlRequest else { return }
        network.request(request: request)
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("success")
                }
            } receiveValue: { [weak self] data in
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
            .store(in: &cancellables)
    }

    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
