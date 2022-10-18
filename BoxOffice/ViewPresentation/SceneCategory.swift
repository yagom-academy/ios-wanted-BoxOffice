//
//  SceneCateogyr.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation

indirect enum SceneCategory {
    case main(mainScene)
    case detail(detailScene)
    case close //그냥 닫기
    case closeWithAction(SceneCategory)
    case alert(AlertDependency)
    
    enum mainScene {
        case firstViewController(context: SceneContext<FirstModel>)
        case firstViewControllerWithAction(context: SceneContext<FirstSceneAction>)
    }
    
    enum detailScene {
        case secondViewController(context: SceneContext<SecondModel>)
        case thirdViewController(context: SceneContext<ThirdModel>)
    }
}
