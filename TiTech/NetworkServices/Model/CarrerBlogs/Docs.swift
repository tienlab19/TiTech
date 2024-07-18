/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Docs : Codable, Equatable {
	let _id : String?
	let images : Images?
	let topic : [Topic]?
	let language : String?
	let homePagePosition : String?
	let title : String?
	let slug : String?
	let excerpt : String?
	let type : String?
	let label : String?
	let publishDate : String?
	let groupTopic : GroupTopic?
	let createdAt : String?
	let estimatedMinutesRead : Int?
	let writer : Writer?

	enum CodingKeys: String, CodingKey {

		case _id = "_id"
		case images = "images"
		case topic = "topic"
		case language = "language"
		case homePagePosition = "homePagePosition"
		case title = "title"
		case slug = "slug"
		case excerpt = "excerpt"
		case type = "type"
		case label = "label"
		case publishDate = "publishDate"
		case groupTopic = "groupTopic"
		case createdAt = "createdAt"
		case estimatedMinutesRead = "estimatedMinutesRead"
		case writer = "writer"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		_id = try values.decodeIfPresent(String.self, forKey: ._id)
		images = try values.decodeIfPresent(Images.self, forKey: .images)
		topic = try values.decodeIfPresent([Topic].self, forKey: .topic)
		language = try values.decodeIfPresent(String.self, forKey: .language)
		homePagePosition = try values.decodeIfPresent(String.self, forKey: .homePagePosition)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		slug = try values.decodeIfPresent(String.self, forKey: .slug)
		excerpt = try values.decodeIfPresent(String.self, forKey: .excerpt)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		label = try values.decodeIfPresent(String.self, forKey: .label)
		publishDate = try values.decodeIfPresent(String.self, forKey: .publishDate)
		groupTopic = try values.decodeIfPresent(GroupTopic.self, forKey: .groupTopic)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		estimatedMinutesRead = try values.decodeIfPresent(Int.self, forKey: .estimatedMinutesRead)
		writer = try values.decodeIfPresent(Writer.self, forKey: .writer)
	}
    
    static func == (lhs: Docs, rhs: Docs) -> Bool {
        return lhs._id == rhs._id
    }
}
