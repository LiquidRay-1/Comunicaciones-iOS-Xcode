//
//  ViewController.swift
//  Comunicaciones
//
//  Created by ITE on 27/11/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
        //downloadPost()
    }
    func downloadData(){
        let urlString = "https://rickandmortyapi.com/api/character"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                print(response)
                print("Response code: \(response.statusCode)")
            }
            
            guard let data = data else { return }
            do {
                //let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                let json = try JSONDecoder().decode(CharacterModelResponse.self, from: data)
                for pj in json.results {
                    print(pj.name)
                }
                print("bye!")
            }catch let jsonError {
                print(jsonError)
            }
            
            //let str = String(decoding: data, as: UTF8.self)
            //print(str)
        }.resume()
        print("Se ha lanczado la petición")
    }
    
    func downloadPost(){
        let urlString = "https://qastusoft.co,.es/apis/frase.php"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/x-ww-form-urlencoded", forHTTPHeaderField: "Content-type")
        
        let bodyData = "centro=estech&anio=2023"
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                print(response)
                print("Response code: \(response.statusCode)")
            }
            
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                print(json["name"] as! String)
                print("bye")
            }catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
}

