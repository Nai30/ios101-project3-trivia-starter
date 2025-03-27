//
//  TriviaService.swift
//  Trivia
//
//  Created by Naima Marseille on 3/22/25.
//

import Foundation
class TriviaService{
    static func fetchTriviaElements (completion: @escaping ([Question]) -> Void){
         let url = URL(string:"https://opentdb.com/api.php?amount=7")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error==nil else{
                assertionFailure("Invalid response")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else{
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResponse.statusCode==200 else{
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            do {
            let decoder=JSONDecoder()
             let response=try decoder.decode(TriviaAPIResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.results) //array of questions
                }
            } catch {
                print("error decoding data:\(error)")
            }
          
        }
        task.resume()
    }
}
