//
//  Saying.swift
//  SmallComponents
//
//  Created by Mephisto on 2022/3/8.
//

import Foundation

public struct SayingManager {
    static let share = SayingManager()
    private init() {}

    private let list: [Saying] = [
        Saying(en: "To be both a speaker of words and a doer of deeds.", zh: "既当演说家，又做实干家"),
        Saying(en: "Variety is the spice of life.", zh: "变化是生活的调味品"),
        Saying(en: "There is no royal road to learning.", zh: "求知无坦途"),
        Saying(en: "Doubt is the key to knowledge.", zh: "怀疑是知识的钥匙"),
        Saying(en: "The greatest test of courage on earth is to bear defeat without losing heart.", zh: "世界上对勇气的最大考验是忍受失败而不丧失信心")
    ]

    var randomSaying: Saying {
        list.randomElement() ?? Saying(en: "There is no royal road to learning.", zh: "求知无坦途")
    }
}

public struct Saying {
    let en: String
    let zh: String
}
