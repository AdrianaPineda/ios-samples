//
//  ComicApiClient.swift
//  CollectionViewSample
//
//  Created by Adriana Pineda on 28/06/2020.
//  Copyright © 2020 Adriana Pineda. All rights reserved.
//

import Alamofire
import AlamofireImage
import Foundation
import Promises

enum ComicApiClientError: Error {
    case comicNotFound
    case imageNotFound
}

struct ComicResponse {
    var title: String
    var img: String
}

extension ComicResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case img
        case title
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        img = try values.decode(String.self, forKey: .img)
    }
}

class ComicApiClient {
    func fetchComic(id: Int) -> Promise<Comic> {
        let promise = Promise<Comic> { fulfill, reject in
            AF.request("https://xkcd.com/\(id)/info.0.json").responseJSON { response in
                guard let data = response.data else {
                    reject(ComicApiClientError.comicNotFound)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let comicResponse = try decoder.decode(ComicResponse.self, from: data)
                    self.fetchImage(url: comicResponse.img).then { imageData in
                        let comic = Comic(title: comicResponse.title, image: imageData)
                        fulfill(comic)
                    }

                } catch {
                    reject(ComicApiClientError.comicNotFound)
                }
            }
        }

        return promise
    }

    private func fetchImage(url: String) -> Promise<Data> {
        let promise = Promise<Data> { fulfill, reject in
            AF.request(url).responseImage { (response: AFDataResponse<Image>) in
                guard let image = response.data else {
                    reject(ComicApiClientError.imageNotFound)
                    return
                }

                fulfill(image)
            }
        }

        return promise
    }
}
