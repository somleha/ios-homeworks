//
//  File.swift
//  Navigation
//
//  Created by Алексей Самойлов on 22.03.2023.
//

import Foundation

protocol Posts {
    var author: String {get set}
    var description: String {get set}
    var image: String {get set}
    var likes: Int {get set}
    var views: Int {get set}
    
}
struct PostForApp: Posts {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
    
    static func make() -> [PostForApp] {
        [
            PostForApp(
                author: "Darth Vader",
                description: "Верховный совет Империи принял решение рассмотреть возможность применения звезды смерти по планете Земля, так как они видят самовольное поведение народов Земли. Если каждый правитель планеты Земля не присегнет верности Империи, то Верховный совет империи примет незамедлительное решение. Также Верховный совет империи видит активности повстанческих формирований на территории планеты Земля.",
                image: "StarWars",
                likes: 777,
                views: 50000
            ),
            PostForApp(
                author: "Twilight sparkle",
                description: "Отважный радужный конь может быть завербован повстанческим формированием. Только он может отразить удар звезды смерти в случае соответствующего решения верховного совета Империи. Именно этот радужный конь наша надежда в эти сложные времена. Что я пишу, я не понимаю, но эта картинка была прикольной и хорошего качества, поэтому я трачу свое время на сочинение немыслимых текстов.",
                image: "Pony",
                likes: 1000,
                views: 2000
            ),
            PostForApp(
                author: "Ilon Mask",
                description: "Я изобрел новую машину робота-убийцу преступников, которая работает на основе СhatGPT и скоро заменит всех полицейских на улицах. Обычные пули его не пробивают и он четко следует букве закона в любых ситуациях. Это необходимо, чтобы мы знали, что закон нельзя нарушать и любые преступления будут караться. Он также может считывать эмоции человека и заранее пресекать намерения к совершению преступлений.",
                image: "Robocop",
                likes: 12000,
                views: 14000
            ),
            PostForApp(
                author: "Memes_live",
                description: "Не странные букашки, супер-нинзя черепашки практически смогли повторить известный в сети мем, им не хватило только +1 черепашки. Какой такой мем? Догадайтесь сами. Фотография искусства супер-нинзя черепашек приложена к новости. Сеть уже оценила их творчество лайками",
                image: "Turtles",
                likes: 10000,
                views: 12000
            )
        ]
    }
}

