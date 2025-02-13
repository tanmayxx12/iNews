//
//  PreviewData.swift
//  iNews
//
//  Created by Tanmay . on 13/02/25.
//

import Foundation

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let previewData = NewsResponse(status: "ok"
                                   , totalResults: 13251,
                                   articles: [
                                    NewsResponse.Article(source: NewsResponse.Source(id: nil, name: "Portfolio.hu"),
                                                                   title: "Váratlan vendég bukkant fel az Ovális Irodában: Elon Musk kiállt a drasztikus lépései mellett",
                                                                   url: "https://www.portfolio.hu/global/20250212/varatlan-vendeg-bukkant-fel-az-ovalis-irodaban-elon-musk-kiallt-a-drasztikus-lepesei-mellett-740783",
                                                                   publishedAt: "2025-02-12T08:01:00Z",
                                                                   content: "Az emberek jelents kormányzati reformra szavaztak, és az emberek ezt fogják kapni. Errl szól a demokrácia\r\n- jelentette ki Elon Musk. Az MTI beszámolója szerint a milliárdos visszautasította, hogy \"e… [+4011 chars]",
                                                                   author: "Portfolio.hu",
                                                                   description:  "A Tesla és a SpaceX vezérigazgatója, Elon Musk kedden az Ovális Irodában védte meg a kormányzati hatékonysági hivatal (DOGE) munkáját újságírók előtt, miközben Donald Trump amerikai elnök mellette ült - tudósított a Hill.",
                                                                   urlToImage: "https://pcdn.hu/articles/images-xl/d/o/n/donald-trump-elon-musk-ovalis-iroda-feher-haz-doge-732221.jpg") 
                                   ])
}
