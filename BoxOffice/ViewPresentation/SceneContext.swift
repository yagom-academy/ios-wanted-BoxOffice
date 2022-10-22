//
//  SceneContext.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation

class SceneContext<Dependency> {
    let dependency: Dependency
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
}
