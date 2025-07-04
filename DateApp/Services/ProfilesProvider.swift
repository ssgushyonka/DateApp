import Foundation

final class ProfilesProvider {
    private let bundle: Bundle
    private let decoder = JSONDecoder()
    
    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }
    
    enum ProfilesError: Error {
        case fileNotFound
        case invalidData
        case decodingFailed(Error)
    }
    
    func getProfiles(offset: Int = 0, completion: @escaping (Result<[Profile], ProfilesError>) -> Void) {
        DispatchQueue.global().async {
            // 1. Проверяем существование файла
            guard let url = self.bundle.url(forResource: "profiles.response", withExtension: "json") else {
                DispatchQueue.main.async {
                    completion(.failure(.fileNotFound))
                }
                return
            }
            
            do {
                // 2. Читаем данные
                let data = try Data(contentsOf: url)
                print("JSON data:", String(data: data, encoding: .utf8) ?? "Не удалось конвертировать в строку")
                
                // 3. Декодируем
                let response = try self.decoder.decode(ProfilesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.profiles))
                }
            } catch let decodingError as DecodingError {
                print("Decoding error:", decodingError)
                DispatchQueue.main.async {
                    completion(.failure(.decodingFailed(decodingError)))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
            }
        }
    }
}
