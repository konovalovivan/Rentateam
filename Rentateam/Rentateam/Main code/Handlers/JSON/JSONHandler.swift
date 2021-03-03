import Foundation


protocol Worker {
    typealias AnyCodable = Any & Codable
    static func work<T>(with data: Data, _ storage: Storage?, _ completion: @escaping (Result<T?,Error>)->()) where T:AnyCodable
}

class Handler: Worker {
    
    /// Function for processing data
    /// - Parameter data: Data that needs to be processed for subsequent output
    static func work<T>(with data: Data, _ storage: Storage? = nil, _ completion: @escaping (Result<T?,Error>)->()) where T:AnyCodable {
        // Working with the received data
        do {
            let model = try jsonDecoder().decode(T?.self, from: data)
            if let feed = model as? Feed {
                
                var indices = feed.indices.reduce(0, +)
                
                // The sum of the indices is needed to implement
                // method completion when enumerating elements asynchronously
                
                for (index,post) in feed.enumerated() {
                    guard let url = post.urls.small else { fatalError() }
                    API.get(to: url, with: { data in
                        guard let data = try? data.get() else { fatalError() }
                        storage?.images[post.id] = data
                        indices -= index
                        indices == 0 ? completion(.success(model)) : nil
                    })
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
