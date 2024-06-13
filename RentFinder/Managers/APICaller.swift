import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    func login(with loginRequest: LoginRequest, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/user/login") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        guard let requestBody = try? JSONEncoder().encode(loginRequest) else {
            completion(.failure(NSError(domain: "Failed to encode request", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response from server", code: -1, userInfo: nil)))
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                if let data = data,
                   let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    completion(.failure(NSError(domain: errorResponse.msg, code: httpResponse.statusCode, userInfo: nil)))
                } else {
                    completion(.failure(NSError(domain: "Invalid response from server", code: httpResponse.statusCode, userInfo: nil)))
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received from server", code: -1, userInfo: nil)))
                return
            }
            
            if let result = try? JSONDecoder().decode(AuthResponse.self, from: data) {
                UserDefaults.standard.set(result.token, forKey: "authToken")
                completion(.success(result))
            } else {
                completion(.failure(NSError(domain: "Failed to parse response", code: -1, userInfo: nil)))
            }
        }.resume()
    }
    
    func register(with userRequest: RegisterRequest, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/user/register") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        guard let requestBody = try? JSONEncoder().encode(userRequest) else {
            completion(.failure(NSError(domain: "Failed to encode request", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response from server", code: -1, userInfo: nil)))
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                if let data = data,
                   let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    completion(.failure(NSError(domain: errorResponse.msg, code: httpResponse.statusCode, userInfo: nil)))
                } else {
                    completion(.failure(NSError(domain: "Invalid response from server", code: httpResponse.statusCode, userInfo: nil)))
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received from server", code: -1, userInfo: nil)))
                return
            }
            
            if let result = try? JSONDecoder().decode(RegisterResponse.self, from: data) {
                completion(.success(result))
            } else {
                completion(.failure(NSError(domain: "Failed to parse response", code: -1, userInfo: nil)))
            }
        }.resume()
    }
    
    func getUserReservations(completion: @escaping (Result<[Reservation], Error>) -> Void) {
            guard let url = URL(string: "http://localhost:8080/reservation/getAllUserReservations") else {
                completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
                return
            }
            
            guard let token = UserDefaults.standard.string(forKey: "authToken") else {
                completion(.failure(NSError(domain: "No token found", code: -1, userInfo: nil)))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NSError(domain: "Invalid response from server", code: -1, userInfo: nil)))
                    return
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    completion(.failure(NSError(domain: "Failed to fetch user reservations", code: httpResponse.statusCode, userInfo: nil)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data received from server", code: -1, userInfo: nil)))
                    return
                }
                
                if let json = try? JSONDecoder().decode([Reservation].self, from: data) {
                    print("JSON Response: \(json)")
                    completion(.success(json))
                } else {
                    completion(.failure(NSError(domain: "Failed to parse response", code: -1, userInfo: nil)))
                }
            }.resume()
        }
    
    func submitReview(for propertyID: Int, reservationID: Int, reviewRequest: ReviewRequest, completion: @escaping (Result<ReviewResponse, Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            completion(.failure(NSError(domain: "No token found", code: -1, userInfo: nil)))
            return
        }
        
        guard let url = URL(string: "http://localhost:8080/review/\(propertyID)/\(reservationID)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        guard let requestBody = try? JSONEncoder().encode(reviewRequest) else {
            completion(.failure(NSError(domain: "Failed to encode request", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestBody
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response from server", code: -1, userInfo: nil)))
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                if let data = data,
                   let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    completion(.failure(NSError(domain: errorResponse.msg, code: httpResponse.statusCode, userInfo: nil)))
                } else {
                    completion(.failure(NSError(domain: "Invalid response from server", code: httpResponse.statusCode, userInfo: nil)))
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received from server", code: -1, userInfo: nil)))
                return
            }
            
            if let result = try? JSONDecoder().decode(ReviewResponse.self, from: data) {
                completion(.success(result))
            } else {
                completion(.failure(NSError(domain: "Failed to parse response", code: -1, userInfo: nil)))
            }
        }.resume()
    }

}
