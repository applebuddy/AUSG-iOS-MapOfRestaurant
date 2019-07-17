import Alamofire

struct RatingService {
    /* 추가 부분 시작 */
    // 별점 등록하기
    // POST /rating
    func postRatingInformation(rating: Int, locationId: Int, completionHandler: @escaping (RatingInformation) -> Void) {
        let params = ["rating" : rating,
                      "locationId" : locationId] as [String : Any]
        Alamofire.request("\(SERVER_URL)/ratings",
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: nil).responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    do {
                        let ratingInformation = try JSONDecoder().decode(RatingInformation.self, from: data)
                        completionHandler(ratingInformation)
                    } catch {
                        print("Got and error: \(error)")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    /* 추가 부분 끝 */
}
